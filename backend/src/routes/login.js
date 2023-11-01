const bcrypt = require("bcrypt");
const mysql = require("../mysql-connector");

/**
 * @param {import("express").Response} response
 * @param {string} username
 * @param {string} password
 * @param {"Admin" | "Customer" | "Employee" | "Manager"} loginType
 * @returns whether the response has been sent
 */
function checkLogin(response, username, password, loginType) {
	let query = undefined;
	if (loginType == "Admin") {
		// TODO
	} else if (loginType == "Customer") {
		query = `SELECT * FROM web_platform_user WHERE user_name = ?`;
	} else if (loginType == "Employee") {
		query = `SELECT * FROM employee WHERE user_name = ? AND position = 'Staff'`;
	} else if (loginType == "Manager") {
		query = `SELECT * FROM employee WHERE user_name = ? AND position = 'Manager'`;
	}

	if (query == undefined) {
		response.status(500).send("Internal server error occured");
		return true;
	}

	return new Promise((resolve) => {
		mysql.query(query, [username], (error, results) => {
			if (error) {
				response.status(500).send("Internal server error occured");
				resolve(true);
				return;
			}
			const user = results[0];
			if (typeof user == "undefined") {
				resolve(false);
				return;
			}

			bcrypt.compare(password, user.Password, (err, result) => {
				if (err) {
					console.error(err);
					response.status(500).send("Internal server error occured");
					resolve(true);
					return;
				}

				if (result == false) {
					response.status(400).send("Invalid credentials");
					resolve(true);
					return;
				}

				delete user.Password;
				response.status(200).send(user);
				resolve(true);
			});
		});
	});
}

async function handler(request, response) {
	const { emailAddress, password, type } = request.body;

	if (
		typeof emailAddress != "string" ||
		typeof password != "string" ||
		typeof type != "string"
	) {
		response.status(400).send("Not all required fields are provided");
		return;
	}
	if (
		type != "Admin" &&
		type != "Employee" &&
		type != "Manager" &&
		type != "Customer"
	) {
		response.status(400).send(`Unknown value for type is provided: ${type}`);
		return;
	}

	let responseSent = false;
	responseSent = await checkLogin(response, emailAddress, password, type);
	if (responseSent) {
		return;
	}

	// user doesn't exist
	response.status(400).send("Invalid credentials");
}

module.exports = handler;
