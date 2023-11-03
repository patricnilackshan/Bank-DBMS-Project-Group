import React, { useState } from "react";
import { backend } from "../utilities";
import { Link, useNavigate } from "react-router-dom";

export default function (props) {
	const [username, setUsername] = useState("");
	const [password, setPassword] = useState("");
	const [loginError, setLoginError] = useState("");

	const navigate = useNavigate();

	return (
		<div className="Auth-form-container">
			<form className="Auth-form-small">
				<div className="Auth-form-content">
					<h3 className="Auth-form-title">Welcome to A!</h3>

					<div className="form-group mt-3">
						<label>Username</label>
						<input
							onChange={(event) => {
								setUsername(event.target.value);
							}}
							type="text"
							className="form-control mt-1"
							placeholder="Enter username"
							value={username}
						/>
					</div>

					<div className="form-group mt-3">
						<label>Password</label>
						<input
							value={password}
							type="password"
							className="form-control mt-1"
							onChange={(event) => {
								setPassword(event.target.value);
							}}
							placeholder="Enter password"
						/>
					</div>
					{loginError == "" ? null : <div>{loginError}</div>}

					<div className="d-grid gap-2 mt-3">
						<button
							type="submit"
							className="btn btn-primary"
							onClick={(event) => {
								event.preventDefault();
								backend("/login", {
									method: "POST",
									body: {
										username,
										password,
										type: "Admin",
									},
								}).then((data) => {
									if (typeof data == "string") {
										setLoginError(data);
										return;
									}
									navigate("/Admin");
								});
							}}
						>
							Submit
						</button>
					</div>

					<div className="d-grid gap-2 mt-3">
						<Link to="/">
						<button
							className="backbutton-small"
							style={{ verticalAlign: "middle" }}
							type="submit"
						>
							<span>Back </span>
						</button>
						</Link>
					</div>

					<p className="forgot-password text-mid mt-3" align="center">
						<a href="/PasswordResetAdmin" style={{ color: "black" }}>
							Forgot password?
						</a>
					</p>
				</div>
			</form>
		</div>
	);
}
