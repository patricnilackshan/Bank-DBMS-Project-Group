import React from "react";
import { Link } from "react-router-dom";
import "./Parts.css";

export function Customer() {
	return (
		<div className="Auth-form-container">
			<form className="Auth-form">
				<div className="Auth-form-content">
					<h3 className="Auth-form-title" align="center">
						Welcome Back!
					</h3>
					<Link to="/ViewCustomer">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Get Profile Details </span>
						</button>
					</Link>
					<br />
					<Link to="/ViewBalance">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Get Account Details </span>
						</button>
					</Link>
					<br />
					<Link to="/Transaction">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Do a Transaction </span>
						</button>
					</Link>
					<br />
					<Link to="/ApplyLoan">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Apply for an Online Loan </span>
						</button>
					</Link>
					<br />
					{/* <Link to="/CreateFD">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Start a Fixed Deposit </span>
						</button>
					</Link>
					<br /> */}

					<Link to="/CheckInstallments">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Check Loan Installments </span>
						</button>
					</Link>
					<br />
					{/* <Link to="/PayInstallment">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Pay Loan Installments </span>
						</button>
					</Link>
					<br /> */}
					<Link to="/Statement">
						<button className="button" style={{ verticalAlign: "middle" }}>
							<span>Get Bank Statement </span>
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

	const htmlContent = `
        <!DOCTYPE html>
        <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            </head>
            <body>
            </body>
        </html>
    `;

	return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
