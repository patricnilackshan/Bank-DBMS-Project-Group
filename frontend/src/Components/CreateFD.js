import React from 'react';
import "./Parts.css"

export function CreateFD() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Customer">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Enter the Details</h3>

                            <div class="row">
                                <div class="col-25">
                                    <label>Account Number</label>
                                </div>
                                <div class="col-75">
                                    <input
                                        type="number"
                                        className="form-control mt-1"
                                        placeholder="Enter your savings account number "
                                        size="48"
                                    />
                                </div>
                            </div>

                            <div class="row">                               
                                <div class="col-25">
                                    <label>Amount</label> 
                                </div>
                                <div class="col-75">
                                    <input
                                        type="number"
                                        className="form-control mt-1"
                                        placeholder="Enter amount in SCR"
                                    />
                                </div>
                            </div>

                            <div class="row">
                            <div class="col-25">
                                <label for="fdtype">FD Plan Type</label>
                            </div>
                            <div class="col-75">
                                <select id="fdtype" name="fdtype">
                                    <option value="none">Choose an option</option>
                                    <option value="six">6 Months</option>
                                    <option value="one">1 Year</option>
                                    <option value="three">3 Years</option>
                                </select>
                            </div>
                        </div>

                            <div class="row">
                                <div class="col-25">
                                    <label>Password</label>
                                </div>
                                <div class="col-75">
                                    <input
                                        type="password"
                                        className="form-control mt-1"
                                        placeholder="Enter your password"
                                        size="48"
                                    />
                                </div>
                            </div>

                            <br>
                            <div class="row">
                                <input type="submit" value="Confirm">
                            </div>
                            <button class="backbutton" style="vertical-align:middle" formAction="/Customer"><span>Back </span></button>
                                                        
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}