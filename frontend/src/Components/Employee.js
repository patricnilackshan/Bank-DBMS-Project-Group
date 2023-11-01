import React from 'react';
import './Parts.css';

export function Employee() {
  return (
    <div className="Auth-form-container-big">
      <form className="Auth-form" action="/Employee">
        <div className="Auth-form-content">
          <h3 className="Auth-form-title" align="center">Welcome Back!</h3>
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/ViewEmployee">
            <span>Get Profile Details</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/ChooseCustomer">
            <span>Register a New Customer</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/ChooseAccount">
            <span>Open a New Bank Account</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/EmployeeTransaction">
            <span>Update a Deposit, Transaction, or Withdrawal</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/LoanDetails">
            <span>View Loan Details</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/PaymentDate">
            <span>Update Payment Date</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/GetCustomerEmployee">
            <span>Get Customer Details</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/CreateRequest">
            <span>Create a Loan Request</span>
          </button><br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/">
            <span>Log Out</span>
          </button>
        </div>
      </form>
    </div>
  );
}
