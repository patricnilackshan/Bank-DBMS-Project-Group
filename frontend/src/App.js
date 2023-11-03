import "bootstrap/dist/css/bootstrap.min.css";
import "./App.css";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Auth from "./Components/Auth";
import PasswordReset from "./Components/PasswordReset";
import { Manager } from "./Components/Manager";
import { CreateEmployee } from "./Components/CreateEmployee";
import { GenerateReport } from "./Components/generatereport";
import { Employee } from "./Components/Employee";
import { Admin } from "./Components/Admin";
import { CreateManager } from "./Components/CreateManager";
import { SelectUser } from "./Components/selectuser";
import AdminAuth from "./Components/AdminAuth";
import { Customer } from "./Components/Customer";
import CustomerAuth from "./Components/CustomerAuth";
import EmployeeAuth from "./Components/EmployeeAuth";
import PasswordResetAdmin from "./Components/PasswordResetAdmin";
import PasswordResetCustomer from "./Components/PasswordResetCustomer";
import PasswordResetEmployee from "./Components/PasswordResetEmployee";
import { ChooseCustomer } from "./Components/ChooseCustomer";
import { CreateCustomer } from "./Components/CreateCustomer";
import { CreateOrganization } from "./Components/CreateOrganization";
import { CustomerOpinion } from "./Components/CustomerOpinion";
import { CreateUser } from "./Components/CreateUser";
import { ManualAccount } from "./Components/ManualAccount";
import { ChooseAccount } from "./Components/ChooseAccount";
import { CreateSavings } from "./Components/CreateSavings";
import { CreateCurrent } from "./Components/CreateCurrent";
import { Transaction } from "./Components/Transaction";
import { ApplyLoan } from "./Components/ApplyLoan";
import { CreateRequest } from "./Components/CreateRequest";
import { CreateFD } from "./Components/CreateFD";
import { EmployeeTransaction } from "./Components/EmployeeTransaction";
import { PhysicalTransaction } from "./Components/PhysicalTransaction";
import { Deposit } from "./Components/Deposit";
import { Withdrawal } from "./Components/Withdrawal";
import { ApproveRequest } from "./Components/ApproveRequest";
import { ViewCustomer } from "./Components/ViewCustomer";
import { ViewEmployee } from "./Components/ViewEmployee";
import { ViewManager } from "./Components/ViewManager";
import { GetCustomerEmployee } from "./Components/GetCustomerEmployee";
import { GetCustomerManager } from "./Components/GetCustomerManager";
import { Statement } from "./Components/Statement";
import { LoanDetails } from "./Components/LoanDetails";
import { PaymentDate } from "./Components/PaymentDate";
import { ReportHistory } from "./Components/ReportHistory";
import { ViewBalance } from "./Components/ViewBalance";
import { CheckInstallments } from "./Components/CheckInstallments";
import { PayInstallment } from "./Components/PayInstallment";
import { ViewRequest } from "./Components/ViewRequest";
import { useEffect, useState } from "react";

export default function App() {
	const [username, setUsername] = useState("");

	useEffect(() => {
		console.log("global username", username);
	}, [username]);

	return (
		<BrowserRouter>
			<Routes>
				<Route path="/" element={<SelectUser />} />
				<Route path="/passwordreset" element={<PasswordReset />} />
				<Route path="/manager" element={<Manager />} />
				<Route path="/createemployee" element={<CreateEmployee />} />
				<Route
					path="/generatereport"
					element={<GenerateReport username={username} />}
				/>
				<Route path="/employee" element={<Employee />} />
				<Route path="/admin" element={<Admin />} />
				<Route path="/createmanager" element={<CreateManager />} />
				<Route path="/selectuser" element={<SelectUser />} />
				<Route path="/adminauth" element={<AdminAuth />} />
				<Route
					path="/auth"
					element={<Auth setGlobalUsername={setUsername} />}
				/>
				<Route path="/customer" element={<Customer />} />
				<Route
					path="/customerauth"
					element={<CustomerAuth setGlobalUsername={setUsername} />}
				/>
				<Route path="/employeeauth" element={<EmployeeAuth />} />
				<Route path="/passwordresetadmin" element={<PasswordResetAdmin />} />
				<Route
					path="/passwordresetcustomer"
					element={<PasswordResetCustomer />}
				/>
				<Route
					path="/passwordresetemployee"
					element={<PasswordResetEmployee />}
				/>
				<Route path="/choosecustomer" element={<ChooseCustomer />} />
				<Route path="/createcustomer" element={<CreateCustomer />} />
				<Route path="/createorganization" element={<CreateOrganization />} />
				<Route path="/customeropinion" element={<CustomerOpinion />} />
				<Route path="/createuser" element={<CreateUser />} />
				<Route path="/manualaccount" element={<ManualAccount />} />
				<Route path="/chooseaccount" element={<ChooseAccount />} />
				<Route path="/createsavings" element={<CreateSavings />} />
				<Route path="/createcurrent" element={<CreateCurrent />} />
				<Route
					path="/transaction"
					element={<Transaction username={username} />}
				/>
				<Route path="/applyloan" element={<ApplyLoan username={username} />} />
				<Route path="/createrequest" element={<CreateRequest />} />
				<Route path="/createfd" element={<CreateFD />} />
				<Route path="/employeetransaction" element={<EmployeeTransaction />} />
				<Route path="/physicaltransaction" element={<PhysicalTransaction />} />
				<Route path="/deposit" element={<Deposit />} />
				<Route path="/withdrawal" element={<Withdrawal />} />
				<Route path="/approverequest" element={<ApproveRequest username={username} />} />
				<Route path="/viewcustomer" element={<ViewCustomer username={username} />} />
				<Route path="/viewemployee" element={<ViewEmployee />} />
				<Route path="/viewmanager" element={<ViewManager username={username} />} />
				<Route path="/getcustomeremployee" element={<GetCustomerEmployee />} />
				<Route path="/getcustomermanager" element={<GetCustomerManager username={username} />} />
				<Route path="/statement" element={<Statement username={username} />} />
				<Route path="/loandetails" element={<LoanDetails />} />
				<Route path="/paymentdate" element={<PaymentDate />} />
				<Route path="/reporthistory" element={<ReportHistory />} />
				<Route path="/viewbalance" element={<ViewBalance username={username} />} />
				<Route path="/checkinstallments" element={<CheckInstallments />} />
				<Route path="/payinstallment" element={<PayInstallment />} />
				<Route path="/viewrequest" element={<ViewRequest username={username} />} />
			</Routes>
		</BrowserRouter>
	);
}

//export default App

// const root = ReactDOM.createRoot(document.getElementById("root"));
//root.render(<Manager />);
// root.render(<App />);
