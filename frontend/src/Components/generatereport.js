import React from 'react';
import "./Parts.css"

export function GenerateReport() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Manager">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Generate a Report</h3>

                            <div class="row">
                                <div class="col-25">
                                    <label for="type">Type</label>
                                </div>
                                <div class="col-75">
                                    <select id="type" name="type">
                                        <option value="none">Choose an option</option>
                                        <option value="transreport">Branchwise Total Transaction Report</option>
                                        <option value="loanreport">Branchwise Late Loan Installment Report</option>
                                    </select>
                                </div>
                            </div>
                          
                            <div class="row">                               
                                <div class="col-25">
                                    <label>From</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="date"
                                        className="form-control mt-1"                                        
                                    />
                                </div>
                            </div>

                            <div class="row">                               
                                <div class="col-25">
                                    <label>To</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="date"
                                        className="form-control mt-1"                                         
                                    />
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <input type="submit" value="Generate">
                            </div>
                            <button class="backbutton" style="vertical-align:middle" formAction="/Manager"><span>Back </span></button>
                            
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
