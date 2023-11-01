import React from 'react';
import './Parts.css';

export function CreateOrganization() {
    return (
        <div className="Auth-form-container-big">
            <form className="Auth-form" action="/Employee">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title" align="center">Fill the details of the Organization</h3>

                    <div className="row">
                        <div className="col-25">
                            <label>Organization Name</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="text"
                                className="form-control mt-1"
                                placeholder="Enter organization name"
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
                            <label>Email Address</label>
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
                            <label>Responsible Person ID</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="number"
                                className="form-control mt-1"
                                placeholder="Enter ID"
                            />
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-25">
                            <label>Position</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="text"
                                className="form-control mt-1"
                                placeholder="Enter position"
                            />
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-25">
                            <label>Username</label>
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
                            <label>Password</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="password"
                                className="form-control mt-1"
                                placeholder="Enter password"
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
                            />
                        </div>
                    </div>

                    <br />
                    <div className="row">
                        <input type="submit" value="Submit" />
                    </div>

                    <br />
                    <button className="backbutton" formAction="/ChooseCustomer" type="submit" style={{ color: 'green' }}>
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
