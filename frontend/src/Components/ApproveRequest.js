import React, { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import "./Parts.css";
import { backend } from "../utilities";

export function ApproveRequest({ username }) {
	const [loanRequestDetails, setLoanRequestDetails] = useState({
		loanRequestId: "",
		duration: "",
	});
	const [error, setError] = useState("");

	const navigate = useNavigate();

	const handleInputChange = (event) => {
		const { name, value } = event.target;
		setLoanRequestDetails({ ...loanRequestDetails, [name]: value });
	};

	const submitRequest =
		/**
		 * @param {"Approve" | "Decline"} action
		 */
		(action) => {
			backend("/approve-request", {
				body: {
					...loanRequestDetails,
					action,
					username,
				},
			}).then((data) => {
				if (typeof data == "string") {
					setError(data);
					return;
				}
				setError("");
				setTimeout(() => {
					navigate(-1);
				}, 1000);
			});
		};

	return (
		<div className="Auth-form-container">
			<form className="Auth-form">
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
								value={loanRequestDetails.loanRequestId}
								name="loanRequestId"
								onChange={handleInputChange}
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
								value={loanRequestDetails.duration}
								name="duration"
								onChange={handleInputChange}
							/>
						</div>
					</div>

					<br />
					{error == "" ? null : <div>{error}</div>}
					<div className="row">
						<input
							type="submit"
							value="Approve"
							onClick={() => {
								submitRequest("Approve");
							}}
						/>
					</div>

					<br />
					<div className="row">
						<input
							type="submit"
							value="Decline"
							onClick={() => {
								submitRequest("Decline");
							}}
						/>
					</div>

					<br />
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
