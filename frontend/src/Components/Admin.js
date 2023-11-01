import React from 'react';
import './Parts.css';

export function Admin() {
	return (
		<div class="Auth-form-container">
			<form class="Auth-form" action="/Admin">
				<div class="Auth-form-content">
					<h3 class="Auth-form-title" align="center">
						Welcome Back!
					</h3>
					<button
						class="button"
						style={{ verticalAlign: "middle" }}
						formAction="/CreateManager"
					>
						<span>Create a Manager Account</span>
					</button>
					<br />
					<button
						class="button"
						style={{ verticalAlign: "middle" }}
						formAction="/CreateEmployee"
					>
						<span>Create an Employee Account</span>
					</button>
					<br />
					<button
						class="button"
						style={{ verticalAlign: "middle" }}
						formAction="/ReportHistory"
					>
						<span>View Report Generation History</span>
					</button>
					<br />
					<button
						class="button"
						style={{ verticalAlign: "middle" }}
						formAction="/"
					>
						<span>Log Out</span>
					</button>
				</div>
			</form>
		</div>
	);
}
