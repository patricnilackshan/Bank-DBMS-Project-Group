import React from 'react';
import './Parts.css';

export function ViewRequest() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form" action="/Manager">
        <div className="Auth-form-content">
          <button className="backbutton" style={{ verticalAlign: 'middle' }} formAction="/Manager">
            <span>Back</span>
          </button>
        </div>
      </form>
    </div>
  );
}
