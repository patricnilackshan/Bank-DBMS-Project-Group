import React from 'react';
import "./Parts.css"

export function PhysicalTransaction() {
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
                                <label>Sender's Customer ID</label> </div>
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
                                    <label>From</label>
                                </div>
                                <div class="col-75">
                                    <input
                                        type="number"
                                        className="form-control mt-1"
                                        placeholder="Enter the sender's account number"
                                        size="48"
                                    />
                                </div>
                            </div>
                                                    
                            <div class="row">
                                <div class="col-25">
                                    <label>To</label>
                                </div>
                                <div class="col-75">
                                    <input
                                        type="number"
                                        className="form-control mt-1"
                                        placeholder="Enter the receipient's account number"
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
                                        min="1000"
                                        max="999999"
                                    />
                                </div>
                            </div>

                            <br>
                            <div class="row">
                                <input type="submit" value="Send">
                            </div>
                            <button class="backbutton" style="vertical-align:middle" formAction="/EmployeeTransaction"><span>Back </span></button>
                                                        
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}