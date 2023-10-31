import React from 'react';
import './Parts.css';

export function Employee() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            </head>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Employee">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Welcome Back!</h3>
                            <button class="button" style="vertical-align:middle" formAction="/ViewEmployee"><span>Get Profile Details </span></button><br>  
                            <button class="button" style="vertical-align:middle" formAction="/ChooseCustomer"><span>Register a New Customer</span></button><br>                   
                            <button class="button" style="vertical-align:middle" formAction="/ChooseAccount"><span>Open a New Bank Account</span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/EmployeeTransaction"><span>Upadate a Deposit, Transaction or Withdrawal</span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/CreateRequest"><span>Create a Loan Request</span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/"><span>Log Out</span></button>                          
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
