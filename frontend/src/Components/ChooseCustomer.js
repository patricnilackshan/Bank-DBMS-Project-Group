import React from 'react';
import './Parts.css';

export function ChooseCustomer() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form">
                <div className="Auth-form-content">
                    <button className="button" style={{ verticalAlign: "middle" }} formAction="/CreateCustomer">
                        <span>Register an Individual</span>
                    </button><br />
                    <button className="button" style={{ verticalAlign: "middle" }} formAction="/CreateOrganization">
                        <span>Register an Organization</span>
                    </button>
                    <button className="backbutton" formAction="/Employee" type="submit" style={{ color: "green" }}>
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
