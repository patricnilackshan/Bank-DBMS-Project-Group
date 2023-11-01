import React from 'react';
import './Parts.css';

export function SelectUser() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form-small">
        <div className="Auth-form-content">
          <h1 className="Auth-form-title">Who are you?</h1>
          <ul id="menu">
            <li>
              <p>I am a/an ...</p>
              <ul>
                <li><a href="./AdminAuth">Admin</a></li>
                <li><a href="./CustomerAuth">Customer</a></li>
                <li><a href="./EmployeeAuth">Employee</a></li>
                <li><a href="./Auth">Manager</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </form>
    </div>
  );
}
