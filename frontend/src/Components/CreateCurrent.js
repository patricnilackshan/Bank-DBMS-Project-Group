import React from 'react';
import "./Parts.css"

export function CreateCurrent() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Employee">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Create a Current Account</h3>

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
                                <label for="branch">Branch</label>
                            </div>
                            <div class="col-75">
                                <select id="branch" name="branch">
                                    <option value="none">Choose an option</option>
                                    <option value="anseboileau">Anse Boileau</option>
                                    <option value="glacis">Glacis</option>
                                    <option value="plaisance">Plaisance</option>
                                    <option value="Takamaka">Takamaka</option>
                                    <option value="victoria">Victoria</option>
                                </select>
                            </div>
                        </div>
                          

                    <div class="row">                               
                    <div class="col-25">
                        <label>Initial Amount</label> </div>
                        <div class="col-75">
                        <input
                            type="number"
                            className="form-control mt-1"
                            placeholder="Enter initial amount in SCR"
                            min="1000"
                            max="999999"
                        />
                    </div>
                </div>
                            <br>
                            <div class="row">
                                <input type="submit" value="Create Account">
                            </div>

                            <button class="backbutton" style="vertical-align:middle" formAction="/ChooseAccount"><span>Back </span></button>
                            
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
