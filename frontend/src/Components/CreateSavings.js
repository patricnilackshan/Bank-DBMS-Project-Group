import React from 'react';
import './Parts.css';

export function CreateSavings() {
    return (
        <div className="Auth-form-container">
            <form className="Auth-form" action="/Employee">
                <div className="Auth-form-content">
                    <h3 className="Auth-form-title" align="center">Create a Savings Account</h3>

                    <div className="row">
                        <div className="col-25">
                            <label>Customer ID</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="number"
                                className="form-control mt-1"
                                placeholder="Enter ID"
                            />
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-25">
                            <label>Branch</label>
                        </div>
                        <div className="col-75">
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

                    <div className="row">
                        <div className="col-25">
                            <label>Savings Plan</label>
                        </div>
                        <div className="col-75">
                            <select id="savingsPlan" name="savingsPlan">
                                <option value="none">Choose an option</option>
                                <option value="adult">Adult</option>
                                <option value="children">Children</option>
                                <option value="senior">Senior</option>
                                <option value="teen">Teen</option>
                            </select>
                        </div>
                    </div>

                    <div className="row">
                        <div className="col-25">
                            <label>Initial Amount</label>
                        </div>
                        <div className="col-75">
                            <input
                                type="number"
                                className="form-control mt-1"
                                placeholder="Enter initial amount in SCR"
                                min="1000"
                                max="999999"
                            />
                        </div>
                    </div>

                    <br />
                    <div className="row">
                        <input type="submit" value="Create Account" />
                    </div>

                    <button className="backbutton" style={{ verticalAlign: 'middle' }} formAction="/ChooseAccount">
                        <span>Back</span>
                    </button>
                </div>
            </form>
        </div>
    );
}
