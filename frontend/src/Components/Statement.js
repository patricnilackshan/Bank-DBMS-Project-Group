import React from 'react';
import "./Parts.css"

export function Statement() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form" action="/Customer">
                        <div class="Auth-form-content">

                            <button class="backbutton" style="vertical-align:middle" formAction="/Customer"><span>Back </span></button>
                                                        
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}