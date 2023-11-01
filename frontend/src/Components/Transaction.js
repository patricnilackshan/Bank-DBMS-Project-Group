import React from 'react';
import './Parts.css';

export function Transaction() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form" action="/Customer">
        <div className="Auth-form-content">
          <h3 className="Auth-form-title" align="center">Enter the Details</h3>

          <div className="row">
            <div className="col-25">
              <label>From</label>
            </div>
            <div className="col-75">
              <input
                type="number"
                className="form-control mt-1"
                placeholder="Enter your account number"
                size="48"
              />
            </div>
          </div>

          <div className="row">
            <div className="col-25">
              <label>To</label>
            </div>
            <div className="col-75">
              <input
                type="number"
                className="form-control mt-1"
                placeholder="Enter the recipient's account number"
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
              <label>Password</label>
            </div>
            <div className="col-75">
              <input
                type="password"
                className="form-control mt-1"
                placeholder="Enter your password"
                size="48"
              />
            </div>
          </div>

          <br />

          <div className="row">
            <input type="submit" value="Send" />
          </div>

          <button className="backbutton" style={{ verticalAlign: 'middle' }} formAction="/Customer">
            <span>Back</span>
          </button>
        </div>
      </form>
    </div>
  );
}
