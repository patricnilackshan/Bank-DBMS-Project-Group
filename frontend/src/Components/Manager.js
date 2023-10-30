import React from 'react';
import './Parts.css';

export function Manager() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            </head>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Manager">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Welcome Back!</h3>                   
                            <button class="button" style="vertical-align:middle" formAction="/GenerateReport"><span>Generate a Report </span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/ViewRequest"><span>View Loan Requests </span></button><br>
                            <button class="button" style="vertical-align:middle" formAction="/"><span>Log Out</span></button>                          
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
