import React from 'react';
import './Parts.css';

export function Statement() {
  return (
    <div className="Auth-form-container">
      <form className="Auth-form" action="/Customer">
        <div className="Auth-form-content">
          <button className="backbutton" style={{ verticalAlign: 'middle' }} formAction="/Customer">
            <span>Back</span>
          </button>
        </div>
      </form>
    </div>
  );
}
