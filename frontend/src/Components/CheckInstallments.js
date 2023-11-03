import React from "react";
import { Link } from "react-router-dom";
import "./Parts.css";

export function CheckInstallments() {
	return (
		<div className="Auth-form-container">
			<form className="Auth-form" action="/Customer">
				<div className="Auth-form-content">
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
