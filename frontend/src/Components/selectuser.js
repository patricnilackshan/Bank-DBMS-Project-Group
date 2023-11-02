import React from "react";
import { Link } from "react-router-dom";
import "./Parts.css";

export function SelectUser() {
	return (
		<div className="Auth-form-container">
			<form className="Auth-form-small">
				<div className="Auth-form-content">
					<h1 className="Auth-form-title">Who are you?</h1>
					<ul id="menu">
						<li>
							<p>I am a/an ...</p>
							<ul>
								<li>
									<Link to="/AdminAuth">Admin</Link>
								</li>
								<li>
									<Link to="/CustomerAuth">Customer</Link>
								</li>
								<li>
									<Link to="/EmployeeAuth">Employee</Link>
								</li>
								<li>
									<Link to="/Auth">Manager</Link>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</form>
		</div>
	);
}
