const mysql = require("../mysql-connector");

/**
 * @param {import("express").Request} request
 * @param {import("express").Response} response
 */
async function handler(request, response) {
	const { username } = request.query;

	console.log({ username });
	if (typeof username != "string") {
		response.status(400).send("username is missing");
		return;
	}
	mysql.query(`CALL get_account_details(?)`, [username], (err, results) => {
		if (err) {
			console.error(err);
			response.status(500).send("Internal server error occured");
			return;
		}

		console.log(results);
		response.status(200).send(results[0][0]);
	});
}

module.exports = handler;
