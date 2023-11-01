import React from 'react';
import "./Parts.css"

export function PaymentDate() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form" action="/Employee">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title" align="center">Update Payment Date</h3>

                    <div className="row">
                        <div className="col-25">
                            <label>Loan ID</label>
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
                            <label>New Date</label>
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
                        <input type="submit" value="Update" />
                    </div>
                    <button className="backbutton" style={{ verticalAlign: "middle" }} formAction="/Employee">
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
