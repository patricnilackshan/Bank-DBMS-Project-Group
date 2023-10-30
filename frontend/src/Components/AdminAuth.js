import React from "react";

export default function (props) {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form-small">
        <div className="Auth-form-content">
          <h3 className="Auth-form-title">Welcome to A!</h3>

          <div className="form-group mt-3">
            <label>Username</label>
            <input
              type="text"
              className="form-control mt-1"
              placeholder="Enter username"
            />
          </div>

          <div className="form-group mt-3">
            <label>Password</label>
            <input
              type="password"
              className="form-control mt-1"
              placeholder="Enter password"
            />
          </div>

          <div className="d-grid gap-2 mt-3">
            <button formAction="/Admin" type="submit" className="btn btn-primary">
              Submit
            </button>
          </div>

          <div className="d-grid gap-2 mt-3">
            <button className="backbutton-small" style={{ verticalAlign: "middle" }} formAction="/" type="submit"><span>Back </span></button>
            </div>

          <p className="forgot-password text-mid mt-3" align="center">
             <a href="/PasswordResetAdmin"  style={{ color: "black" }}>Forgot password?</a>
          </p>

        </div>
      </form>
    </div>
  )
}