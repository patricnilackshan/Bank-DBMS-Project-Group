import React from 'react';
import "./Parts.css"

export function CreateRequest() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Employee">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Enter the Details</h3>

                            <div class="row">                               
                            <div class="col-25">
                                <label>Customer ID</label> </div>
                                <div class="col-75">
                                <input
                                    type="number"
                                    className="form-control mt-1"
                                    placeholder="Enter ID"
                                />
                            </div>
                            </div>

                            <div class="row">
                                <div class="col-25">
                                    <label>Account Number</label>
                                </div>
                                <div class="col-75">
                                    <input
                                        type="number"
                                        className="form-control mt-1"
                                        placeholder="Enter the account number linked with the fixed deposit"
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
                                        placeholder="Enter loan amount in SCR"
                                    />
                                </div>
                            </div>

                            <div class="row">                               
                            <div class="col-25">
                                <label>Loan Type</label> </div>
                                    <div class="col-75">
                                    <input type="radio" id="business" name="business" value="Business">
                                    <label for="male">Business</label>
                                    <input type="radio" id="personal" name="personal" value="Personal">
                                    <label for="female">Personal</label><br>
                            </div>
                            </div>

                            <br>
                            <div class="row">
                                <input type="submit" value="Request">
                            </div>
                            <button class="backbutton" style="vertical-align:middle" formAction="/Employee"><span>Back </span></button>
                                                        
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}