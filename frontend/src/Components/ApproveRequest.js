import React from 'react';
import "./Parts.css"

export function ApproveRequest() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Manager">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Enter the Details</h3>

                            <div class="row">
                                <div class="col-25">
                                    <label>Loan ID</label>
                                </div>
                                <div class="col-75">
                                    <input
                                        type="number"
                                        className="form-control mt-1"
                                        placeholder="Enter loan ID"
                                        size="48"
                                    />
                                </div>
                            </div>

                            <div class="row">
                            <div class="col-25">
                                <label>Duration</label>
                            </div>
                            <div class="col-75">
                                <input
                                    type="number"
                                    className="form-control mt-1"
                                    placeholder="Enter duration in months"
                                    size="48"
                                />
                            </div>
                            </div>

                            <br>
                            <div class="row">
                                <input type="submit" value="Approve">
                            </div>

                            <br>
                            <div class="row">
                                <input type="submit" value="Decline">
                            </div>

                            <br>
                            <button class="backbutton" style="vertical-align:middle" formAction="/Manager"><span>Back </span></button>
                                                        
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}