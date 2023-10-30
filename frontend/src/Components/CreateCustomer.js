import React from 'react';
import './Parts.css'

export function CreateCustomer() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container-medium">
                    <form class="Auth-form" action="/CustomerOpinion">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Fill the details of the customer</h3>

                            <div class="row">
                            <div class="col-25">
                                <label>First Name</label> </div>
                                <div class="col-75">
                                <input
                                    type="text"
                                    className="form-control mt-1"
                                    placeholder="Enter first name"
                                /></div>
                            </div>

                            <div class="row">
                            <div class="col-25">
                                <label>Last Name</label> </div>
                                <div class="col-75">
                                <input
                                    type="text"
                                    className="form-control mt-1"
                                    placeholder="Enter last name"
                                /></div>
                            </div>

                            <div class="row">                               
                                <div class="col-25">
                                    <label>NIC Number</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="text"
                                        className="form-control mt-1"
                                        placeholder="Enter NIC number"
                                    />
                                </div>
                            </div>
                            
                            <div class="row">                               
                                <div class="col-25">
                                    <label>Telephone Number</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="text"
                                        className="form-control mt-1"
                                        placeholder="Enter telephone number"
                                         
                                    />
                                </div>
                            </div>

                            <div class="row">                               
                                <div class="col-25">
                                    <label>Address</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="text"
                                        className="form-control mt-1"
                                        placeholder="Enter address"
                                         
                                    />
                                </div>
                            </div>

                            <div class="row">                               
                                <div class="col-25">
                                    <label>Date of Birth</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="date"
                                        className="form-control mt-1"                                        
                                    />
                                </div>
                            </div>

                            <div class="row">                               
                            <div class="col-25">
                                <label>Gender</label> </div>
                                    <div class="col-75">
                                    <input type="radio" id="male" name="gender" value="Male">
                                    <label for="male">Male</label>
                                    <input type="radio" id="female" name="gender" value="Female">
                                    <label for="female">Female</label><br>
                            </div>
                            </div>

                            <br>
                            <div class="row">
                                <input type="submit" value="Submit">
                            </div>

                            <br>
                            
                                <button class="backbutton" formAction="/ChooseCustomer" type="submit" color=green><span>Back </span></button>
                            
                    
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
