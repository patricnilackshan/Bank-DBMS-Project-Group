import React from 'react';
import "./Parts.css"

export function PaymentDate() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Employee">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Update Payment Date</h3>

                            <div class="row">                               
                            <div class="col-25">
                                <label>Loan ID</label> </div>
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
                                    <label>New Date</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="date"
                                        className="form-control mt-1"                                         
                                    />
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <input type="submit" value="Update">
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
