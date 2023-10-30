import React from 'react';
import './Parts.css';

export function Customer() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            </head>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Customer">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Welcome Back!</h3>  
                            <button class="button" style="vertical-align:middle" formAction="/ViewBalance"><span>Get Account Details </span></button><br>                 
                            <button class="button" style="vertical-align:middle" formAction="/Transaction"><span>Do a Transaction </span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/ApplyLoan"><span>Apply for an Online Loan </span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/CreateFD"><span>Start a Fixed Deposit </span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/PayInstallment"><span>Pay Loan Installments </span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/"><span>Log Out</span></button>                          
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
