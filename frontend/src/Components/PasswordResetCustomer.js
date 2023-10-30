import React from "react";

export default function PasswordResetCustomer(){
    return (
        <div className="Auth-form-container">
            <form className="Auth-form-small">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title">Reset Your Password</h3>

                    <div className="form-group mt-3">
                        <label>Email</label>
                        <input
                            type="email"
                            className="form-control mt-1"
                            placeholder="Enter email"
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

                    <div className="form-group mt-3">
                        <label>Confirm Password</label>
                        <input
                            type="password"
                            className="form-control mt-1"
                            placeholder="Confirm password"
                        />
                    </div>

                    <div className="d-grid gap-2 mt-3">                       
                        <button formAction="/CustomerAuth" type="submit" className="btn btn-primary">
                            Submit
                        </button>                       
                    </div>
                </div>
            </form>
        </div>
                
    )
}
