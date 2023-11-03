import React from "react";
import { Link } from "react-router-dom";
import "./Parts.css";

export function ApplyLoan() {
	return (
		<div className="Auth-form-container">
			<form className="Auth-form" action="/Customer">
				<div className="Auth-form-content">
					<h3 className="Auth-form-title" align="center">
						Enter the Details
					</h3>

					<div className="row">
						<div className="col-25">
							<label>Account Number</label>
						</div>
						<div className="col-75">
							<input
								type="number"
								className="form-control mt-1"
								placeholder="Enter the account number linked with the fixed deposit"
								size="48"
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Amount</label>
						</div>
						<div className="col-75">
							<input
								type="number"
								className="form-control mt-1"
								placeholder="Enter loan amount in SCR"
								min="1000"
								max="999999"
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Loan Type</label>
						</div>
						<div className="col-75">
							<input
								type="radio"
								id="business"
								name="loanType"
								value="Business"
							/>
							<label htmlFor="business">Business</label>
							<input
								type="radio"
								id="personal"
								name="loanType"
								value="Personal"
							/>
							<label htmlFor="personal">Personal</label>
							<br />
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

					<div className="row">
						<div className="col-25">
							<label>Password</label>
						</div>
						<div className="col-75">
							<input
								type="password"
								className="form-control mt-1"
								placeholder="Enter your password"
								size="48"
							/>
						</div>
					</div>

					<br />
					<div className="row">
						<input type="submit" value="Apply" />
					</div>
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
