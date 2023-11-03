import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import "./Parts.css";
import { backend } from "../utilities";

export function ViewManager({ username }) {
	const [details, setDetails] = useState({});
	const [error, setError] = useState("");

	useEffect(() => {
		backend("/get-profile-details", {
			body: {
				username,
			},
		}).then((data) => {
			if (typeof data == "string") {
				setError(data);
				return;
			}
			setError("");
			setDetails(data);
		});
	}, []);

	return (
		<div className="Auth-form-container">
			<form className="Auth-form">
				<div className="Auth-form-content">
					{error != "" ? (
						<div>{error}</div>
					) : (
						<table className="table table-striped">
							<tbody>
								{Object.entries(details).map(([key, value]) => {
									return (
										<tr key={key}>
											<td>{key}</td>
											<td>{value}</td>
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
