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
	return new Promise((resolve) => {
		mysql.query(
			`SELECT * FROM web_platform_user AS wpu
			LEFT JOIN employee
			ON employee.user_name = wpu.user_name
			WHERE wpu.user_name = ?`,
			[username],
			(error, results) => {
				if (error) {
					console.error(error);
					response.status(500).send("Internal server error occured");
					resolve(true);
					return;
				}
				const user = results[0];
				if (typeof user == "undefined") {
					console.log("not found");
					resolve(false);
					return;
				}

				user.user_name = user.user_name || username;
				console.log(user);

				const isManager =
					user.position == "Manager" || user.position == "Head_Manager";
				const isInvalidCredentials =
					user.status == "Retired" ||
					(loginType == "Admin" && user.user_name != "admin") ||
					(loginType != "Admin" && user.user_name == "admin") ||
					((loginType == "Employee" || loginType == "Manager") &&
						user.status != "Active") ||
					(loginType == "Employee" && user.position != "Staff") ||
					(loginType == "Manager" && !isManager) ||
					(loginType != "Manager" && isManager);

				if (isInvalidCredentials) {
					resolve(false);
					return;
				}

				bcrypt.compare(password, user.password_hash, (err, result) => {
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

					delete user.password_hash;
					response.status(200).send(user);
					resolve(true);
				});
			}
		);
	});
}

async function handler(request, response) {
	const { username, password, type } = request.body;

	if (
		typeof username != "string" ||
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
	responseSent = await checkLogin(response, username, password, type);
	if (responseSent) {
		return;
	}

	// user doesn't exist
	response.status(400).send("Invalid credentials");
}

module.exports = handler;
