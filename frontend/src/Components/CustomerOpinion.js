import React from 'react';
import './Parts.css';

export function CustomerOpinion() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            </head>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form">
                        <div class="Auth-form-content">
                            <h3 class="Auth-form-title" align="center">Does the Customer Want to Use the Web Platform?</h3>
                            <button class="button" style="vertical-align:middle" formAction="/CreateUser"><span>Yes, Create an Account.</span></button><br>                   
                            <button class="button" style="vertical-align:middle" formAction="/Employee"><span>No, Go to Home Page.</span></button><br>                         
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
