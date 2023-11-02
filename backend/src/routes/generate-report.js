const mysql = require("../mysql-connector");

/**
 * @param {import("express").Request} request
 * @param {import("express").Response} response
 */
async function handler(request, response) {
	const { username, startDate, endDate, type } = request.query;

	console.log({ username, startDate, endDate });
	if (
		typeof username != "string" ||
		typeof startDate != "string" ||
		typeof endDate != "string"
	) {
		response.status(400).send("Not all requried parameters are provided");
		return;
	}
	let procedureName = undefined;
	if (type == "transreport") {
		procedureName = "generate_branch_transaction_report";
	} else if (type == "loanreport") {
		procedureName = "generate_branch_late_loan_report";
	} else {
		response.status(400).send(`Invalid value provided for type ${type}`);
		return;
	}

	mysql.query(
		`CALL ${procedureName}(?,?,?)`,
		[username, startDate, endDate],
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
