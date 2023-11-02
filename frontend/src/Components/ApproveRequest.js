import React from "react";
import { Link } from "react-router-dom";
import "./Parts.css";

export function ApproveRequest() {
	return (
		<div className="Auth-form-container">
			<form className="Auth-form" action="/Manager">
				<div className="Auth-form-content">
					<h3 className="Auth-form-title" align="center">
						Enter the Details
					</h3>

					<div className="row">
						<div className="col-25">
							<label>Loan ID</label>
						</div>
						<div className="col-75">
							<input
								type="number"
								className="form-control mt-1"
								placeholder="Enter loan ID"
								size="48"
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Duration</label>
						</div>
						<div className="col-75">
							<input
								type="number"
								className="form-control mt-1"
								placeholder="Enter duration in months"
								size="48"
							/>
						</div>
					</div>

					<br />
					<div className="row">
						<input type="submit" value="Approve" />
					</div>

					<br />
					<div className="row">
						<input type="submit" value="Decline" />
					</div>

					<br />
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
