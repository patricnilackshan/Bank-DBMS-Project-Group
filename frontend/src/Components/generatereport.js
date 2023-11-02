import React, { useState } from "react";
import { Link } from "react-router-dom";
import { backend } from "../utilities";
import "./Parts.css";

export function GenerateReport({ username }) {
	const [reportDetails, setReportDetails] = useState({
		type: "",
		startDate: "",
		endDate: "",
	});
	const [error, setError] = useState("");
	const [reportItems, setReportItems] = useState([]);

	const handleChange = (event) => {
		const { name, value } = event.target;
		console.log("change", name, value);
		setReportDetails({
			...reportDetails,
			[name]: value,
		});
	};

	const submit = (event) => {
		console.log(username);
		setError("");
		event.preventDefault();
		if (reportDetails.type == "none") {
			setError("Report type is not selected");
			return;
		}
		if (reportDetails.startDate == "") {
			setError("Start date is not provided");
			return;
		}
		if (reportDetails.endDate == "") {
			setError("End date is not provided");
			return;
		}
		backend("/generate-report", {
			body: { ...reportDetails, username },
		}).then((data) => {
			if (typeof data == "string") {
				setError(data);
				return;
			}
			setReportItems(data);
		});
	};

	return (
		<div className="Auth-form-container" style={{ flexDirection: "column" }}>
			<form className="Auth-form" action="/Manager">
				<div className="Auth-form-content">
					<h3 className="Auth-form-title" align="center">
						Generate a Report
					</h3>

					<div className="row">
						<div className="col-25">
							<label htmlFor="type">Type</label>
						</div>
						<div className="col-75">
							<select
								id="type"
								name="type"
								value={reportDetails.type}
								onChange={handleChange}
							>
								<option value="none">Choose an option</option>
								<option value="transreport">
									Branchwise Total Transaction Report
								</option>
								<option value="loanreport">
									Branchwise Late Loan Installment Report
								</option>
							</select>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>From</label>{" "}
						</div>
						<div className="col-75">
							<input
								name="startDate"
								type="date"
								className="form-control mt-1"
								value={reportDetails.startDate}
								onChange={handleChange}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>To</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="date"
								name="endDate"
								className="form-control mt-1"
								onChange={handleChange}
								value={reportDetails.endDate}
							/>
						</div>
					</div>
					<br />
					{error == "" ? null : <div>{error}</div>}
					<div className="row">
						<input type="submit" value="Generate" onClick={submit} />
					</div>
					<Link to="/Manager">
						<button className="backbutton" style={{ verticalAlign: "middle" }}>
						<span>Back </span>
					</button>
					</Link>
				</div>
			</form>
			
			{reportItems.length == 0 ? null : (
				<table
					className="table table-striped"
					style={{ backgroundColor: "#1194e2f2" }}
				>
				<tr>
					<th>Account Number</th>
					<th>Customer Name</th>
					<th>Transaction Type</th>
					<th>Description</th>
					<th>Timestamp</th>
					<th>Amount</th>
				</tr>
					{reportItems.map((item) => {
						return (
							<tr>
						<td>{item["Account Number"]}</td>
						<td>{item["Customer Name"]}</td>
						<td>{item["Transaction Type"]}</td>
						<td>{item["Description"] || "-"}</td>
						<td>{item["Time Stamp"]}</td>
						<td>{item["Amount"]}</td>
					</tr>
						);
				})}
			</table>
			)}
		</div>
	);
}
