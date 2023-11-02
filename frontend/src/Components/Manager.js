import React from "react";
import { Link } from "react-router-dom";
import "./Parts.css";

export function Manager() {
	return (
		<div className="Auth-form-container">
			<form className="Auth-form">
				<div className="Auth-form-content">
					<h3 className="Auth-form-title" align="center">
						Welcome Back!
					</h3>
					<Link to="/ViewManager">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Get Profile Details </span>
						</button>
					</Link>
					<br />
					<Link to="/GenerateReport">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Generate a Report </span>
						</button>
					</Link>
					<br />
					<Link to="/ViewRequest">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>View Loan Requests </span>
						</button>
					</Link>
					<br />
					<Link to="/ApproveRequest">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Approve Loan Requests </span>
						</button>
					</Link>
					<br />
					<Link to="/GetCustomerManager">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Get Customer Details </span>
						</button>
					</Link>
					<br />
					<Link to="/">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Log Out</span>
						</button>
					</Link>
				</div>
			</form>
		</div>
	);
}
