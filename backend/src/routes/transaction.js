const bcrypt = require("bcrypt");
const mysql = require("../mysql-connector");
const { BCRYPT_SALT_ROUNDS } = require("../values");

/**
 * @param {import("express").Request} request
 * @param {import("express").Response} response
 */
async function handler(request, response) {
	let { fromAccount, toAccount, amount, password, username } = request.body;

	amount = parseInt(amount);
	fromAccount = parseInt(fromAccount);
	toAccount = parseInt(toAccount);

	if (
		Number.isNaN(amount) ||
		Number.isNaN(fromAccount) ||
		Number.isNaN(toAccount) ||
		typeof password != "string"
	) {
		response.status(400).send("Not all required fields are given");
		return;
	}

	const responseSent = await new Promise((resolve) => {
		mysql.query(
			`SELECT * FROM account
		LEFT JOIN customer
		ON account.customer_id = customer.customer_id
		LEFT JOIN web_platform_user AS wpa
		ON wpa.user_name = customer.user_name
		WHERE account.account_number = ? AND customer.user_name = ?`,
			[fromAccount, username],
			(err, results) => {
				if (err || !Array.isArray(results) || results.length == 0) {
					console.error(err);
					response.status(500).send("Internal server error occured");
					resolve(true);
					return;
				}
				
				bcrypt.compare(password, results[0]["password_hash"]).then((matched) => {
					if (matched) {
						resolve(false);
						return;
					}
					response.status(400).send("User credentials didn't match");
					resolve(true);
				}).catch(() => {
					response.status(500).send("Internal server error occured");
					resolve(true);
				});
			}
		);
	});

	if (responseSent) return;

	mysql.query(
		"CALL make_online_transfer(?,?,?)",
		[fromAccount, toAccount, amount],
		(error) => {
			if (error) {
				console.error(error);
				response.status(500).send("Internal server error occured");
				return;
			}
			response.status(200).send("done");
		}
	);
}
module.exports = handler;
