import React, { useEffect, useState } from "react";
import "./Parts.css";
import { backend } from "../utilities";;

export function CreateManager() {
	const [branches, setBranches] = useState([]);
	
	useEffect(() => {
		backend("/branches").then(data => {
			if (typeof data == "string") {
				console.error(data);return;
			}
			setBranches(data);
		})
	}, []);

	return (
		<div className="Auth-form-container-big">
			<form className="Auth-form" action="/Admin">
				<div className="Auth-form-content">
					<h3 className="Auth-form-title" align="center">
						Fill the details of the manager
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
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label for="branch">Branch</label>
						</div>
						<div className="col-75">
							<select id="branch" name="branch">
								<option value="none">Choose an option</option>
								{branches.map((branch) => {
									return <option value={branch.branch_id} key={branch.branch_id}>{branch.branch_name}</option>
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
							/>
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Date of Birth</label>{" "}
						</div>
						<div className="col-75">
							<input type="date" className="form-control mt-1" />
						</div>
					</div>

					<div className="row">
						<div className="col-25">
							<label>Gender</label>{" "}
						</div>
						<div className="col-75">
							<input type="radio" id="male" name="gender" value="Male" />
							<label for="male">Male</label>
							<input type="radio" id="female" name="gender" value="Female" />
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
							/>
						</div>
					</div>

					<br />
					<div className="row">
						<input type="submit" value="Submit" />
					</div>

					<br />
					<button
						className="backbutton"
						formAction="/Admin"
						type="submit"
						style={{ color: "green" }}
					>
						<span>Back </span>
					</button>
				</div>
			</form>
		</div>
	);
}	

    //                         <div className="row">
    //                             <div className="col-25">
    //                                 <label for="branch">Branch</label>
    //                             </div>
    //                             <div className="col-75">
    //                                 <select id="branch" name="branch">
    //                                     <option value="none">Choose an option</option>
    //                                     <option value="anseboileau">Anse Boileau</option>
    //                                     <option value="glacis">Glacis</option>
    //                                     <option value="plaisance">Plaisance</option>
    //                                     <option value="Takamaka">Takamaka</option>
    //                                     <option value="victoria">Victoria</option>
    //                                 </select>
    //                             </div>
    //                         </div>
