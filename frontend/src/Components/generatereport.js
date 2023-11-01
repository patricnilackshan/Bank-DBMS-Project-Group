import React, { useState } from "react";
import { backend } from "../utilities";
import "./Parts.css";

export function GenerateReport({ username }) {
	const [reportDetails, setReportDetails] = useState({
		type: "transreport",
		startDate: "2023-01-01",
		endDate: "2023-11-01",
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
		}).then(data => {
			if (typeof data == "string") {
				setError(data);return;
			}
			setReportItems(data);
		});
	};

	return (
		<div className="Auth-form-container">
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
					<button
						className="backbutton"
						style={{ verticalAlign: "middle" }}
						formAction="/Manager"
					>
						<span>Back </span>
					</button>
				</div>
			</form>
		</div>
	);
}
