import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import "./Parts.css";
import { backend } from "../utilities";

export function GetCustomerManager({ username }) {
	const [items, setItems] = useState([]);
	const [error, setError] = useState("");

	useEffect(() => {
		backend("/get-customer-details", {
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
			<div className="Auth-form-content">
				{items.length == 0 ? (
					<div>{error}</div>
				) : (
					<table className="table table-striped">
						<thead>
							<tr>
								<th>Customer ID</th>
								<th>Customer Type</th>
								<th>User Name</th>
								<th>Account Number</th>
								<th>Account Type</th>
								<th>Account Status</th>
								<th>Customer NIC/Reg No</th>
								<th>Balance</th>
								<th>Contact</th>
							</tr>
						</thead>
						<tbody>
							{items.map((item) => {
								return (
									<tr key={item["Customer ID"]}>
										<td>{item["Customer ID"]}</td>
										<td>{item["Customer Type"]}</td>
										<td>{item["User Name"]}</td>
										<td>{item["Account Number"]}</td>
										<td>{item["Account Type"]}</td>
										<td>{item["Account Status"]}</td>
										<td>{item["Customer NIC/Reg No"]}</td>
										<td>{item["Balance"]}</td>
										<td>
											{[
												item["Contact Number"],
												item["Address"],
												item["Email Address"],
											].join("\n")}
										</td>
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
		</div>
	);
}
