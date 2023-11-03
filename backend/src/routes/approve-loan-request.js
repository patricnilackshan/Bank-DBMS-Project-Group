const mysql = require("../mysql-connector");

/**
 * @param {import("express").Request} request
 * @param {import("express").Response} response
 */
async function handler(request, response) {
	const { username, loanRequestId, duration, action } = request.query;

	if (typeof loanRequestId != "string") {
		response.status(400).send("Invalid value passed for loanRequestId");
		return;
	}
	if (typeof duration != "string") {
		response.status(400).send("Invalid value passed for duration");
		return;
	}
	let _loanRequestId = parseInt(loanRequestId);
	let _duration = parseInt(duration);

	let isApproved = undefined;
	if (action == "Approve") {
		isApproved = true;
	} else if (action == "Decline") {
		isApproved = false;
	} else {
		response.status(400).send("Invalid value passed for action");
		return;
	}

	console.log({ username, _loanRequestId, _duration, action });
	if (
		typeof username != "string" ||
		Number.isNaN(_loanRequestId) ||
		Number.isNaN(_duration)
	) {
		response.status(400).send("Not all inputs are in correct shape");
		return;
	}
	mysql.query(
		`CALL approve_loan_request(?,?,?,?)`,
		[username, _loanRequestId, isApproved, _duration],
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
