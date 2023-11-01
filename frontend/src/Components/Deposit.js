import React from 'react';
import './Parts.css';

export function Deposit() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form" action="/Employee">
        <div className="Auth-form-content">
          <h3 className="Auth-form-title" align="center">Enter the Details</h3>

          <div className="row">
            <div className="col-25">
              <label>Customer ID</label>
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
              <label>Account Number</label>
            </div>
            <div className="col-75">
              <input
                type="number"
                className="form-control mt-1"
                placeholder="Enter account number"
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
              <label>Description</label>
            </div>
            <div className="col-75">
              <input
                type="text"
                className="form-control mt-1"
                placeholder="Enter description"
              />
            </div>
          </div>

          <br />
          <div className="row">
            <input type="submit" value="Deposit" />
          </div>
          <button className="backbutton" style={{ verticalAlign: 'middle' }} formAction="/EmployeeTransaction">
            <span>Back </span>
          </button>
        </div>
      </form>
    </div>
  );
}
