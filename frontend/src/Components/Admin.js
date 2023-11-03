import React from "react";
import { Link } from "react-router-dom";
import "./Parts.css";

export function Admin() {
	return (
		<div class="Auth-form-container">
			<form class="Auth-form" action="/Admin">
				<div class="Auth-form-content">
					<h3 class="Auth-form-title" align="center">
						Welcome Back!
					</h3>
					<Link to="/CreateManager">
						<button class="button" style={{ verticalAlign: "middle" }}>
							<span>Create a Manager Account</span>
						</button>
					</Link>
					<br />
					<Link to="/CreateEmployee">
						<button class="button" style={{ verticalAlign: "middle" }}>
							<span>Create an Employee Account</span>
						</button>
					</Link>
					<br />
					<Link to="/ReportHistory">
						<button class="button" style={{ verticalAlign: "middle" }}>
							<span>View Report Generation History</span>
						</button>
					</Link>
					<br />
					<Link to="/">
						<button class="button" style={{ verticalAlign: "middle" }}>
							<span>Log Out</span>
						</button>
					</Link>
				</div>
			</form>
		</div>
	);
}
