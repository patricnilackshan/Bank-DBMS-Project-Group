const mysql = require("../mysql-connector");
const bcrypt = require("bcrypt");

/**
 * @param {import("express").Request} request
 * @param {import("express").Response} response
 */
async function handler(request, response) {
	const { username, amount, accountNumber, duration, type, password } =
		request.body;

	if (typeof amount != "string") {
		response.status(400).send("Invalid value passed for amount");
		return;
	}
	if (typeof duration != "string") {
		response.status(400).send("Invalid value passed for duration");
		return;
	}
	if (typeof accountNumber != "string") {
		response.status(400).send("Invalid value passed for accountNumber");
		return;
	}
	let _amount = parseInt(amount);
	let _duration = parseInt(duration);
	let _accountNumber = parseInt(accountNumber);

	console.log({ username, _amount, _accountNumber, _duration, type });
	if (
		typeof username != "string" ||
		typeof type != "string" ||
		!(type == "Business" || type == "Personal")
	) {
		response.status(400).send("Not all requried parameters are provided");
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
			[_accountNumber, username],
			(err, results) => {
				if (err || !Array.isArray(results) || results.length == 0) {
					console.error(err);
					response.status(500).send("Internal server error occured");
					resolve(true);
					return;
				}

				bcrypt
					.compare(password, results[0]["password_hash"])
					.then((matched) => {
						if (matched) {
							resolve(false);
							return;
						}
						response.status(400).send("User credentials didn't match");
						resolve(true);
					})
					.catch((err) => {
						console.error(err);
						response.status(500).send("Internal server error occured");
						resolve(true);
					});
			}
		);
	});

	if (responseSent) return;

	mysql.query(
		"CALL customer_applied_loan(?,?,?,?,?)",
		[username, _accountNumber, _amount, type, _duration],
		(err, results) => {
			if (err) {
				console.error(err);
				response.status(500).send("Internal server error occured");
				return;
			}

			console.log(results);
			response.status(200).send(results[0]);
		}
	);
}

module.exports = handler;
