import React from 'react';
import './Parts.css'

export function CreateOrganization() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container-big">
                    <form class="Auth-form" action="/Employee">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Fill the details of the Organization</h3>

                            <div class="row">
                            <div class="col-25">
                                <label>Organization Name</label> </div>
                                <div class="col-75">
                                <input
                                    type="text"
                                    className="form-control mt-1"
                                    placeholder="Enter organization name"
                                /></div>
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
                                    <label>Email Address</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="email"
                                        className="form-control mt-1"
                                        placeholder="Enter email address"
                                        size="48"                                         
                                    />
                                </div>
                            </div>

                            <div class="row">                               
                            <div class="col-25">
                                <label>Responsible Person ID</label> </div>
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
                                <label>Position</label> </div>
                                <div class="col-75">
                                <input
                                    type="text"
                                    className="form-control mt-1"
                                    placeholder="Enter position"                                     
                                />
                            </div>
                        </div>


                            <div class="row">                               
                            <div class="col-25">
                                <label>Username</label> </div>
                                <div class="col-75">
                                <input
                                    type="text"
                                    className="form-control mt-1"
                                    placeholder="Enter username"                                     
                                />
                            </div>
                        </div>

                            <div class="row">                               
                                <div class="col-25">
                                    <label>Password</label> </div>
                                    <div class="col-75">
                                    <input
                                        type="password"
                                        className="form-control mt-1"
                                        placeholder="Enter password"
                                        size ="48"                                
                                    />
                                </div>
                            </div>

                                <div class="row">
                                    <div class="col-25">
                                        <label>Confirm Password</label>
                                    </div>
                                    <div class="col-75">
                                        <input
                                            type="password"
                                            className="form-control mt-1"
                                            placeholder="Confirm password"
                                            size="48"
                                        />
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
