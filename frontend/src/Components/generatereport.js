import React from 'react';
import "./Parts.css";

export function GenerateReport() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form" action="/Manager">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title" align="center">Generate a Report</h3>

                    <div className="row">
                        <div className="col-25">
                            <label htmlFor="type">Type</label>
                        </div>
                        <div className="col-75">
                            <select id="type" name="type">
                                <option value="none">Choose an option</option>
                                <option value="transreport">Branchwise Total Transaction Report</option>
                                <option value="loanreport">Branchwise Late Loan Installment Report</option>
                            </select>
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-25">
                            <label>From</label>
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
                            <label>To</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="date"
                                className="form-control mt-1"
                            />
                        </div>
                    </div>
                    <br />
                    <div className="row">
                        <input type="submit" value="Generate" />
                    </div>
                    <button className="backbutton" style={{ verticalAlign: "middle" }} formAction="/Manager">
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
