import React from 'react';
import './Parts.css';

export function EmployeeTransaction() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form">
        <div className="Auth-form-content">
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/Deposit">
            <span>Update a Deposit</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/Withdrawal">
            <span>Update a Withdrawal</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/PhysicalTransaction">
            <span>Update a Transaction</span>
          </button>
          <button className="backbutton" formAction="/Employee" type="submit" style={{ color: 'green' }}>
            <span>Back</span>
          </button>
        </div>
      </form>
    </div>
  );
}
