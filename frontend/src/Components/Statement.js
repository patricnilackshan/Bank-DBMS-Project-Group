import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import "./Parts.css";
import { backend } from "../utilities";

export function Statement({ username }) {
	const [items, setItems] = useState([]);
	const [error, setError] = useState("");

	useEffect(() => {
		backend("/generate-bank-statement", {
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
					{items.length == 0 ? <div>{error || "No entries"}</div> : (
						<table className="table table-striped">
							<thead>
								<tr>
									<th>Transaction ID</th>
									<th>Transaction Type</th>
									<th>Amount</th>
									<th>Description</th>
									<th>Timestamp</th>
								</tr>
							</thead>
							<tbody>
								{items.map((item) => {
									return (
										<tr key={item["Transaction ID"]}>
											<td>{item["Transaction ID"]}</td>
											<td>{item["Transaction Type"]}</td>
											<td>{item["Amount"]}</td>
											<td>{item["Description"]}</td>
											<td>{new Date(item["Time Stamp"]).toLocaleString()}</td>
										</tr>
									);
								})}
							</tbody>
						</table>
					)}
					<Link to="/Customer">
						<button className="backbutton" style={{ verticalAlign: "middle" }}>
							<span>Back</span>
						</button>
					</Link>
				</div>
			</form>
		</div>
	);
}
