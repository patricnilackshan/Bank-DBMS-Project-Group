import React from 'react';
import './Parts.css';

export function CreateFD() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form" action="/Customer">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title" align="center">Enter the Details</h3>

                    <div className="row">
                        <div className="col-25">
                            <label>Account Number</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="number"
                                className="form-control mt-1"
                                placeholder="Enter your savings account number"
                                size="48"
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
                            />
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-25">
                            <label htmlFor="fdtype">FD Plan Type</label>
                        </div>
                        <div className="col-75">
                            <select id="fdtype" name="fdtype">
                                <option value="none">Choose an option</option>
                                <option value="six">6 Months</option>
                                <option value="one">1 Year</option>
                                <option value="three">3 Years</option>
                            </select>
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
                            />
                        </div>
                    </div>

                    <br />
                    <div className="row">
                        <input type="submit" value="Confirm" />
                    </div>
                    <button className="backbutton" style={{ verticalAlign: "middle" }} formAction="/Customer">
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
