require("dotenv").config();

if (process.env.DATABASE_PASSWORD == undefined) {
	console.error(
		"DATABASE_PASSWORD environment variable is undefined, check if .env is present in the current working directory."
	);
	process.exit(2);
}

const mysql = require("mysql2");
const connection = mysql.createConnection({
	host: "localhost",
	user: "root",
	password: process.env.DATABASE_PASSWORD,
	database: "bank_data",
});

connection.connect(function (err) {
	if (err) {
		console.error("Error connecting to database", err);
		return;
	}

	console.log("Connected to database", connection.threadId);
});

module.exports = connection;
