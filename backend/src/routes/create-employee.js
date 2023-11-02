const bcrypt = require("bcrypt");

const mysql = require("../mysql-connector");
const { BCRYPT_SALT_ROUNDS } = require("../values");

/**
 * @typedef NewManagerDetailsObj
 * @prop {string}	firstName
 * @prop {string}	lastName
 * @prop {string}	branch
 * @prop {string}	nicNumber
 * @prop {string}	phoneNumber
 * @prop {string}	address
 * @prop {string}	emailAddress
 * @prop {string}	dateOfBirth
 * @prop {string}	gender
 * @prop {string}	username
 * @prop {string}	password
 * @prop {"staff" | "manager"} type
 */

/**
 * @param {import("express").Request} request
 * @param {import("express").Response} response
 */
async function handler(request, response) {
	let {
		firstName,
		lastName,
		branch,
		nicNumber,
		phoneNumber,
		address,
		email,
		dateOfBirth,
		gender,
		username,
		password,
		type
	} = request.body;

	branch = parseInt(branch);
	nicNumber = parseInt(nicNumber);
	phoneNumber = parseInt(phoneNumber);

	if (
		typeof firstName != "string" ||
		typeof lastName != "string" ||
		typeof address != "string" ||
		typeof email != "string" ||
		typeof password != "string" ||
		typeof phoneNumber != "string" ||
		typeof type != "string" ||
		Number.isNaN(branch) ||
		Number.isNaN(nicNumber) ||
		Number.isNaN(phoneNumber) ||
		!(type == "manager" || type == "staff")
	) {
		response.status(400).send("Not all required fields are given");
		return;
	}
	type = type.charAt(0).toUpperCase().concat(type.slice(1));

	/** @type {string | null} */

	const hashedPassword = await new Promise((resolve) => {
		if (typeof password != "string") {
			resolve(null);
			return;
		}
		bcrypt.hash(password, BCRYPT_SALT_ROUNDS, (err, hash) => {
			if (err) {
				console.error(err);
				resolve(null);
			}
			resolve(hash);
		});
	});
	if (hashedPassword == null) {
		response.status(500).send("Internal server error occured");
		return;
	}
	console.log("hashedPassword", hashedPassword);

	mysql.query(
		`INSERT INTO employee (
    first_name,
    last_name,
    branch_id,
    nic,
    contact_number,
    address,
    date_of_birth,
    gender,
    user_name,
    position,
    salary
	) VALUES (?,?,?,?,?,?,?,?,?,?,?)`,
		[
			firstName,
			lastName,
			branch,
			nicNumber,
			phoneNumber,
			address,
			dateOfBirth,
			gender,
			username,
			type,
			// TODO
			0,
		],
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
