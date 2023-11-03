import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import "./Parts.css";
import { backend } from "../utilities";

export function ApplyLoan({ username }) {
	const [loanInfo, setLoanInfo] = useState({
		accountNumber: "",
		amount: "",
		type: "",
		duration: "",
		password: "",
	});
	const [error, setError] = useState("");
	const navigate = useNavigate();

	const handleChange = (e) => {
		const { name, value } = e.target;
		setLoanInfo({
			...loanInfo,
			[name]: value,
		});
	};

	const submit = () => {
		backend("/apply-loan", {
			method: "POST",
			body: { ...loanInfo, username },
		}).then((data) => {
			if (typeof data == "string") {
				setError(data);
				return;
			}
			setError("");
			navigate("/Customer");
		});
	};

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
								name="accountNumber"
								value={loanInfo.accountNumber}
								onChange={handleChange}
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
								name="amount"
								value={loanInfo.amount}
								onChange={handleChange}
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
								name="type"
								value="Business"
								checked={loanInfo.type == "Business"}
								onChange={handleChange}
							/>
							<label htmlFor="business">Business</label>
							<input
								type="radio"
								id="personal"
								name="type"
								value="Personal"
								checked={loanInfo.type == "Personal"}
								onChange={handleChange}
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
								name="duration"
								className="form-control mt-1"
								placeholder="Enter duration in months"
								size="48"
								value={loanInfo.duration}
								onChange={handleChange}
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
								value={loanInfo.password}
								name="password"
								onChange={handleChange}
							/>
						</div>
					</div>

					<br />
					{error == "" ? null : <div>{error}</div>}
					<div className="row">
						<input type="submit" value="Apply" onClick={submit} />
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
