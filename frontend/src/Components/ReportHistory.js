import React from 'react';
import './Parts.css';

export function ReportHistory() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form">
        <div className="Auth-form-content">
          <button className="backbutton" style={{ verticalAlign: 'middle' }} formAction="/Admin">
            <span>Back</span>
          </button>
        </div>
      </form>
    </div>
  );
}
