import React from 'react';
import './Parts.css';

export function Admin() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form" action="/Admin">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title" align="center">Welcome Back!</h3>
                    <button className="button" style={{ verticalAlign: "middle" }} formAction="/CreateManager">
                        <span>Create a Manager Account</span>
                    </button><br />
                    <button className="button" style={{ verticalAlign: "middle" }} formAction="/CreateEmployee">
                        <span>Create an Employee Account</span>
                    </button><br />
                    <button className="button" style={{ verticalAlign: "middle" }} formAction="/ReportHistory">
                        <span>View Report Generation History</span>
                    </button><br />
                    <button className="button" style={{ verticalAlign: "middle" }} formAction="/">
                        <span>Log Out</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
