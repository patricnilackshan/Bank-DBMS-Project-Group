import React, { useState } from "react";
import "./Parts.css";
import { useNavigate, Link } from "react-router-dom";
import { backend } from "../utilities";

export function Transaction({ username }) {
	const [transactionInfo, setTransactionInfo] = useState({
		fromAccount: "",
		toAccount: "",
		amount: "",
		password: "",
	});
	const [error, setError] = useState("");
	const navigate = useNavigate();

	const handleInputChange = (e) => {
		const { name, value } = e.target;
		setTransactionInfo({
			...transactionInfo,
			[name]: value,
		});
	};

	const handleSubmit = (e) => {
		e.preventDefault();
		backend("/transaction", {
			method: "POST",
			body: { ...transactionInfo, username },
		}).then((data) => {
			if (typeof data == "string") {
				setError(data);
				return;
			}
			setTimeout(() => {
				navigate(-1);
			}, 2000);
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
							<label>From</label>
						</div>
						<div className="col-75">
							<input
								type="number"
								className="form-control mt-1"
								placeholder="Enter your account number"
								size="48"
								name="fromAccount"
								value={transactionInfo.fromAccount}
								onChange={handleInputChange}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>To</label>
						</div>
						<div className="col-75">
							<input
								type="number"
								className="form-control mt-1"
								placeholder="Enter the recipient's account number"
								size="48"
								name="toAccount"
								value={transactionInfo.toAccount}
								onChange={handleInputChange}
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
								placeholder="Enter amount in SCR"
								min="1000"
								max="999999"
								name="amount"
								value={transactionInfo.amount}
								onChange={handleInputChange}
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
								name="password"
								value={transactionInfo.password}
								onChange={handleInputChange}
							/>
						</div>
					</div>

					<br />
					{error == "" ? null : <div>{error}</div>}

					<div className="row">
						<input type="submit" value="Send" onClick={handleSubmit} />
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
