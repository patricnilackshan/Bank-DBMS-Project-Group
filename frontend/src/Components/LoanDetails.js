import React from 'react';
import './Parts.css';

export function LoanDetails() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form" action="/Employee">
                <div className="Auth-form-content">
                    <button className="backbutton" style={{ verticalAlign: 'middle' }} formAction="/Employee">
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
