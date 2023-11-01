import React from 'react';
import './Parts.css';

export function CreateUser() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form" action="/Employee">
        <div className="Auth-form-content">
          <h3 className="Auth-form-title" align="center">Fill the details</h3>

          <div className="row">
            <div className="col-25">
              <label>Username</label>
            </div>
            <div className="col-75">
              <input
                type="text"
                className="form-control mt-1"
                placeholder="Enter username"
              />
            </div>
          </div>

          <div className="row">
            <div className="col-25">
              <label>Email Address</label>
            </div>
            <div className="col-75">
              <input
                type="email"
                className="form-control mt-1"
                placeholder="Enter email address"
                size="48"
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
                placeholder="Enter password"
                size="48"
              />
            </div>
          </div>

          <div className="row">
            <div className="col-25">
              <label>Confirm Password</label>
            </div>
            <div className="col-75">
              <input
                type="password"
                className="form-control mt-1"
                placeholder="Confirm password"
                size="48"
              />
            </div>
          </div>

          <br />
          <div className="row">
            <input type="submit" value="Submit" />
          </div>

          <br />

          <button
            className="backbutton"
            formAction="/CustomerOpinion"
            type="submit"
            style={{ color: 'green' }}
          >
            <span>Back</span>
          </button>
        </div>
      </form>
    </div>
  );
}
