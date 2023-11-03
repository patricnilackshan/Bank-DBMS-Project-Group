import React, { useEffect, useState } from "react";
import "./Parts.css";
import { backend } from "../utilities";
import { useNavigate, Link } from "react-router-dom";

export function CreateEmployee() {
	const [formData, setFormData] = useState({
		firstName: "",
		lastName: "",
		branch: "none",
		nicNumber: "",
		phoneNumber: "",
		address: "",
		emailAddress: "",
		dateOfBirth: "",
		gender: "",
		username: "",
		password: "",
		confirmPassword: "",
	});
	const [error, setError] = useState("");
	const [branches, setBranches] = useState([]);

	const navigate = useNavigate();

	useEffect(() => {
		backend("/branches").then((data) => {
			if (typeof data == "string") {
				console.error(data);
				return;
			}
			setBranches(data);
		});
	}, []);

	const handleChange = (e) => {
		const { name, value } = e.target;
		setFormData({
			...formData,
			[name]: value,
		});
	};

	return (
		<div className="Auth-form-container-big">
			<form className="Auth-form" action="/Admin">
				<div className="Auth-form-content">
					<h3 className="Auth-form-title" align="center">
						Fill the details of your employee
					</h3>

					<div className="row">
						<div className="col-25">
							<label>First Name</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="text"
								className="form-control mt-1"
								placeholder="Enter first name"
								name="firstName"
								value={formData.firstName}
								onChange={handleChange}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Last Name</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="text"
								className="form-control mt-1"
								placeholder="Enter last name"
								name="lastName"
								value={formData.lastName}
								onChange={handleChange}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label htmlFor="branch">Branch</label>
						</div>
						<div className="col-75">
							<select
								id="branch"
								name="branch"
								value={formData.branch}
								onChange={handleChange}
							>
								<option value="none">Choose an option</option>
								{branches.map((branch) => {
									return (
										<option value={branch.branch_id} key={branch.branch_id}>
											{branch.branch_name}
										</option>
									);
								})}
							</select>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>NIC Number</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="text"
								className="form-control mt-1"
								placeholder="Enter NIC number"
								name="nicNumber"
								onChange={handleChange}
								value={formData.nicNumber}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Telephone Number</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="text"
								className="form-control mt-1"
								placeholder="Enter telephone number"
								name="phoneNumber"
								value={formData.phoneNumber}
								onChange={handleChange}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Address</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="text"
								className="form-control mt-1"
								placeholder="Enter address"
								value={formData.address}
								name="address"
								onChange={handleChange}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Email Address</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="email"
								className="form-control mt-1"
								placeholder="Enter email address"
								size="48"
								name="emailAddress"
								onChange={handleChange}
								value={formData.emailAddress}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Date of Birth</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="date"
								className="form-control mt-1"
								name="dateOfBirth"
								onChange={handleChange}
								value={formData.dateOfBirth}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Gender</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="radio"
								id="male"
								name="gender"
								value="Male"
								onChange={handleChange}
								checked={formData.gender == "Male"}
							/>
							<label for="male">Male</label>
							<input
								type="radio"
								id="female"
								name="gender"
								value="Female"
								onChange={handleChange}
								checked={formData.gender == "Female"}
							/>
							<label for="female">Female</label>
							<br />
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Username</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="text"
								className="form-control mt-1"
								placeholder="Enter username"
								name="username"
								value={formData.username}
								onChange={handleChange}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Password</label>{" "}
						</div>
						<div className="col-75">
							<input
								type="password"
								className="form-control mt-1"
								placeholder="Enter password"
								size="48"
								value={formData.password}
								name="password"
								onChange={handleChange}
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Confirm Password</label>
						</div>
						<div className="col-75">
							<input
								type="password"
								className="form-control mt-1"
								placeholder="Confirm password"
								size="48"
								name="confirmPassword"
								value={formData.confirmPassword}
								onChange={handleChange}
							/>
						</div>
					</div>

					<br />
					<div className="row">
						<input
							type="submit"
							value="Submit"
							onClick={(event) => {
								event.preventDefault();
								backend("/create-employee", {
									method: "POST",
									body: { ...formData, type: "staff" },
								}).then((data) => {
									if (typeof data == "string") {
										console.error(data);
										setError(data);
										return;
									}
									setTimeout(() => {
										navigate(-1);
									}, 1000);
								});
							}}
						/>
					</div>

					<br />
					<Link to="/Admin">
						<button
							className="backbutton"
							type="submit"
							style={{ color: "green" }}
						>
							<span>Back </span>
						</button>
					</Link>
				</div>
			</form>
		</div>
	);
}
