import React from 'react';
import './Parts.css';

export function CreateCustomer() {
    return (
        <div className="Auth-form-container-medium">
            <form className="Auth-form" action="/CustomerOpinion">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title" align="center">Fill the details of the customer</h3>

                    <div className="row">
                        <div className="col-25">
                            <label>First Name</label>
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
                            <label>Last Name</label>
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
                            <label>NIC Number</label>
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
                            <label>Telephone Number</label>
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
                            <label>Address</label>
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
                            <label>Date of Birth</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="date"
                                className="form-control mt-1"
                            />
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-25">
                            <label>Gender</label>
                        </div>
                        <div className="col-75">
                            <input type="radio" id="male" name="gender" value="Male" />
                            <label for="male">Male</label>
                            <input type="radio" id="female" name="gender" value="Female" />
                            <label for="female">Female</label><br />
                        </div>
                    </div>

                    <br />
                    <div className="row">
                        <input type="submit" value="Submit" />
                    </div>

                    <br />
                    <button className="backbutton" formAction="/ChooseCustomer" type="submit" style={{ color: "green" }}>
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
