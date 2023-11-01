import React from 'react';
import './Parts.css';

export function ChooseAccount() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form">
                <div className="Auth-form-content">
                    <button className="button" style={{ verticalAlign: "middle" }} formAction="/CreateSavings">
                        <span>Create a Savings Account</span>
                    </button><br />
                    <button className="button" style={{ verticalAlign: "middle" }} formAction="/CreateCurrent">
                        <span>Create a Current Account</span>
                    </button>
                    <button className="backbutton" formAction="/Employee" type="submit" style={{ color: "green" }}>
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
