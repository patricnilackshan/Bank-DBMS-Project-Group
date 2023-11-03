import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import "./Parts.css";
import { backend } from "../utilities";

export function ViewRequest({ username }) {
	const [items, setItems] = useState([]);
	const [error, setError] = useState("");

	useEffect(() => {
		backend("/view-loan-requests", {
			body: {
				username,
			},
		}).then((data) => {
			if (typeof data == "string") {
				setError(data);
				return;
			}
			setError("");
			setItems(data);
		});
	}, []);

	return (
		<div className="Auth-form-container">
			<form className="Auth-form">
				<div className="Auth-form-content">
					{items.length == 0 ? <div>{error}</div> : (
						<table className="table table-striped">
							<thead>
								<tr>
									<th>Request ID</th>
									<th>Customer ID</th>
									<th>Loan Amount</th>
									<th>Loan Type</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								{items.map((item) => {
									return (
										<tr key={item["Request ID"]}>
											<td>{item["Request ID"]}</td>
											<td>{item["Customer ID"]}</td>
											<td>{item["Loan Amount"]}</td>
											<td>{item["Loan Type"]}</td>
											<td>{item["Is Approved"] ? "Approved" : "Declined"}</td>
										</tr>
									);
								})}
							</tbody>
						</table>
					)}
					<Link to="/Manager">
						<button className="backbutton" style={{ verticalAlign: "middle" }}>
							<span>Back</span>
						</button>
					</Link>
				</div>
			</form>
		</div>
	);
}
