const express = require("express");
const cors = require("cors");

const app = express();
const mysql = require("./mysql-connector");
app.use(express.json());
app.use(cors());

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
	console.log(`Server started on http://localhost:${PORT}`);
});

process.on("SIGINT", () => {
	console.log("Closing connection to mysql");
	mysql.end(console.error);
	process.exit(0);
});
