import React from 'react';
import './Parts.css';

export function CustomerOpinion() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form">
        <div className="Auth-form-content">
          <h3 className="Auth-form-title" align="center">Does the Customer Want to Use the Web Platform?</h3>
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/CreateUser">
            <span>Yes, Create an Account.</span>
          </button>
          <br />
          <button className="button" style={{ verticalAlign: 'middle' }} formAction="/Employee">
            <span>No, Go to Home Page.</span>
          </button>
          <br />
        </div>
      </form>
    </div>
  );
}
