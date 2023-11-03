const express = require("express");
const cors = require("cors");

const app = express();
const mysql = require("./mysql-connector");

// routes
const login = require("./routes/login");
const branches = require("./routes/branches");
const createEmployee = require("./routes/create-employee");
const generateReport = require("./routes/generate-report");
const transaction = require("./routes/transaction");
const viewLoanRequests = require("./routes/view-loan-requests");

app.use(express.json());
app.use(cors());

app.post("/login", login);
app.get("/branches", branches);
app.post("/create-employee", createEmployee);
app.get("/generate-report", generateReport);
app.post("/transaction", transaction);
app.get("/view-loan-requests", viewLoanRequests);

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
	console.log(`Server started on http://localhost:${PORT}`);
});

process.on("SIGINT", () => {
	console.log("Closing connection to mysql");
	mysql.end(console.error);
	process.exit(0);
});
