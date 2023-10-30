import React from 'react';
import './Parts.css'

export function SelectUser() {
    const htmlContent = `
        <!DOCTYPE html>
        <html>
            <body>
                <div class="Auth-form-container">
                    <form class="Auth-form-small">
                        <div class="Auth-form-content">
                            <h1 class="Auth-form-title">Who are you?</h1>
                            <ul id="menu">
                            <li>
                              <pl>I am a/an ...</pl>
                              <ul>
                                <li><a href="./AdminAuth">Admin</a></li>
                                <li><a href="./CustomerAuth">Customer</a></li>
                                <li><a href="./EmployeeAuth">Employee</a></li>
                                <li><a href="./Auth">Manager</a></li>
                              </ul>
                            </li>
                          </ul>
                            
                        </div>
                    </form>
                </div>
            </body>
        </html>
    `;

    return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
}
