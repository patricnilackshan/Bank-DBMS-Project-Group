import React from 'react';
import './Parts.css';

export function Manager() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form" action="/Manager">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title" align="center">Welcome Back!</h3>
                    <button className="button" style={{ verticalAlign: 'middle' }} formAction="/ViewManager">
                        <span>Get Profile Details</span>
                    </button>
                    <br />
                    <button className="button" style={{ verticalAlign: 'middle' }} formAction="/GenerateReport">
                        <span>Generate a Report</span>
                    </button>
                    <br />
                    <button className="button" style={{ verticalAlign: 'middle' }} formAction="/ViewRequest">
                        <span>View Loan Requests</span>
                    </button>
                    <br />
                    <button className="button" style={{ verticalAlign: 'middle' }} formAction="/ApproveRequest">
                        <span>Approve Loan Requests</span>
                    </button>
                    <br />
                    <button className="button" style={{ verticalAlign: 'middle' }} formAction="/GetCustomerManager">
                        <span>Get Customer Details</span>
                    </button>
                    <br />
                    <button className="button" style={{ verticalAlign: 'middle' }} formAction="/">
                        <span>Log Out</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
