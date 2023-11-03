--
-- Procedures
--

DELIMITER //

DROP PROCEDURE IF EXISTS make_online_transfer//
CREATE PROCEDURE make_online_transfer(
    IN sender_account_number INT,
    IN receiver_account_number INT,
    IN transfer_amount NUMERIC(8,2)
)
BEGIN
    DECLARE current_balance_sender NUMERIC(10,2);
    DECLARE current_balance_receiver NUMERIC(10,2);
    DECLARE sender_active_status ENUM('Active', 'Suspended', 'Closed');
    DECLARE receiver_active_status ENUM('Active', 'Suspended', 'Closed');
    DECLARE last_transaction_id INT;

    -- Start a transaction
    START TRANSACTION;

    -- Check if the sender's account exists and is active
    SELECT balance, account_status INTO current_balance_sender, sender_active_status
    FROM account
    WHERE account_number = sender_account_number;

    -- Check if the receiver's account exists and is active
    SELECT balance, account_status INTO current_balance_receiver, receiver_active_status
    FROM account
    WHERE account_number = receiver_account_number;

    -- Check if the sender has enough balance
    IF current_balance_sender >= transfer_amount AND sender_active_status = 'Active'
        AND receiver_active_status = 'Active' THEN
        -- Update the sender's account (withdrawal)
        INSERT INTO transaction (amount, transaction_type, description, time_stamp)
        VALUES (transfer_amount, 'Withdrawal', 'Online Transfer', NOW());

        SELECT LAST_INSERT_ID() INTO last_transaction_id;

        INSERT INTO withdrawal (transaction_id, account_number)
        VALUES (last_transaction_id, sender_account_number);

        -- Update the receiver's account (deposit)
        INSERT INTO transaction (amount, transaction_type, description, time_stamp)
        VALUES (transfer_amount, 'Deposit', 'Online Transfer', NOW());

        -- Get the last inserted transaction ID
        SELECT LAST_INSERT_ID() INTO last_transaction_id;

        INSERT INTO deposit (transaction_id, account_number)
        VALUES (last_transaction_id, receiver_account_number);

        -- Commit the transaction
        COMMIT;
    ELSE
        -- Rollback the transaction if conditions are not met
        ROLLBACK;
        CASE
            WHEN current_balance_sender < transfer_amount THEN
                SELECT 'Insufficient balance' AS 'Message';
            WHEN sender_active_status != 'Active' THEN
                SELECT 'Sender account is not active' AS 'Message';
            WHEN receiver_active_status != 'Active' THEN
                SELECT 'Receiver account is not active' AS 'Message';
        END CASE;
    END IF;
END //

DROP PROCEDURE IF EXISTS get_branch_transactions//
CREATE PROCEDURE get_branch_transaction_details(
    IN username VARCHAR(50)
)
BEGIN
    DECLARE branchid INT;

    -- Find the branch assigned to the employee
    SELECT b.branch_id INTO branchid
    FROM employee e
    JOIN branch b ON e.branch_id = b.branch_id
    WHERE e.user_name = username;
    
    -- Retrieve branch transactions
    SELECT
        `Transaction ID`,
        `Transaction Type`,
        `Description`,
        `Amount`,
        `Time Stamp`,
        `Account Number`,
        `Customer ID`,
        `Customer Name`
    FROM transactions_details_view
    WHERE `Branch ID` = branchid;

END //

DROP PROCEDURE IF EXISTS get_profile_details//
CREATE PROCEDURE get_profile_details(
    IN username VARCHAR(50)
)
BEGIN
    IF EXISTS (SELECT 1 FROM customer_details_view WHERE `User Name` = username) THEN
        -- User is a Customer
        SELECT
            `Customer ID`,
            `Customer Type`,
            `User Name`,
            `Customer Name`,
            `Customer NIC/Reg No`,
            `Date of Birth`,
            `Gender`,
            `Address`,
            `Email Address`,
            `Contact Number`
        FROM customer_details_view
        WHERE `User Name` = username;

    ELSE
        -- User is an Employee
        SELECT
            `Employee ID`,
            `Position`,
            `User Name`,
            `Employee Name`,
            `Date of Birth`,
            `Gender`,
            `Address`,
            `Email Address`,
            `Contact Number`,
            `Salary`,
            `Branch Name`,
            `Status`
        FROM employee_details_view
        WHERE `User Name` = username;
    END IF;
END //

DROP PROCEDURE IF EXISTS generate_bank_statement//
CREATE PROCEDURE generate_bank_statement(
    IN username VARCHAR(50)
)
BEGIN
    DECLARE customerid INT UNSIGNED;

    -- Get the customer ID using the username
    SELECT customer_id INTO customerid FROM customer WHERE user_name = username;

    -- Generate Bank Statement for the Customer
    SELECT
        `Transaction ID`,
        `Transaction Type`,
        `Description`,
        `Amount`,
        `Time Stamp`
    FROM transactions_details_view
    WHERE `Customer ID` = customerid AND `Time Stamp` <= CURDATE();
END //

DROP PROCEDURE IF EXISTS get_customer_details//
CREATE PROCEDURE get_customer_details(
    IN username VARCHAR(50)
)
BEGIN
    DECLARE branchid INT;

    -- Get the branch ID for the employee using the username
    SELECT branch_id INTO branchid
    FROM employee
    WHERE user_name = username;

    -- Get relevant customer and account details for the branch
    SELECT
        cd.`Customer ID`,
        cd.`Customer Type`,
        cd.`User Name`,
        cd.`Customer Name`,
        cd.`Customer NIC/Reg No`,
        cd.`Date of Birth`,
        cd.`Gender`,
        cd.`Address`,
        cd.`Email Address`,
        cd.`Contact Number`,
        ad.`Account Number`,
        ad.`Balance`,
        ad.`Account Status`,
        ad.`Account Type`,
        ad.`Savings Plan Type`,
        ad.next_calculation_on AS `Next Calculation On`,
        ad.`Interest Rate`
    FROM customer_details_view cd
    JOIN account_details_view ad ON cd.`Customer ID` = ad.`Customer ID`
    WHERE ad.`Branch ID` = branchid;
END //

DROP PROCEDURE IF EXISTS generate_branch_transaction_report//
CREATE PROCEDURE generate_branch_transaction_report(
    IN username VARCHAR(50),
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    DECLARE branchid INT;
    DECLARE managerid INT;

    -- Get the IDs for the employee using the username
    SELECT branch_id, employee_id INTO branchid, managerid
    FROM employee
    WHERE user_name = username AND position IN ('Manager', 'Head_Manager');

    -- Generate branch-wise transaction report
    SELECT
        `Transaction ID`,
        `Transaction Type`,
        `Description`,
        `Amount`,
        `Time Stamp`,
        `Account Number`,
        `Customer ID`,
        `Customer Name`
    FROM transactions_details_view
    WHERE `Branch ID` = branchid
    AND `Time Stamp` BETWEEN start_date AND end_date;

    INSERT INTO report (report_type, time_stamp, manager_id)
    VALUES ('Transaction Report', NOW(), managerid);
END //

DROP PROCEDURE IF EXISTS generate_branch_late_loan_report//
CREATE PROCEDURE generate_branch_late_loan_report(
    IN username VARCHAR(50),
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    DECLARE branchid INT;
    DECLARE managerid INT;

    -- Get the IDs for the employee using the username
    SELECT branch_id, employee_id INTO branchid, managerid
    FROM employee
    WHERE user_name = username AND position IN ('Manager', 'Head_Manager');

    -- Generate branch-wise late loan installment report
    SELECT
        `Loan ID`,
        `Account Number`,
        `Customer ID`,
        `Customer Name`,
        `Due Date`,
        `Amount`,
        `Payment Date`,
        `Status`
    FROM loan_installments_view
    WHERE `Branch ID` = branchid
    AND `Status` IN ('Late', 'Overdue') AND `Due Date` BETWEEN start_date AND end_date;

    INSERT INTO report (report_type, time_stamp, manager_id) 
    VALUES ('Loan Installment Report', NOW(), managerid);
END //

DROP PROCEDURE IF EXISTS generate_offline_loan_request//
CREATE PROCEDURE generate_offline_loan_request(
    IN accountnumber INT,
    IN loanamount NUMERIC(8,2),
    IN loantype ENUM('Business', 'Personal'),
    IN username VARCHAR(50)
)
BEGIN
    DECLARE customerid INT;
    DECLARE branchid INT;

    -- Get customer_id based on the account number
    SELECT customer_id
    INTO customerid
    FROM account
    WHERE account_number = accountnumber;

    -- Get branch_id based on the account number
    SELECT branch_id
    INTO branchid
    FROM employee
    WHERE user_name = username;

    -- Insert record into loan_request table
    INSERT INTO loan_request (customer_id, account_number, branch_id, loan_amount, loan_type)
    VALUES (customerid, accountnumber, branchid, loanamount, loantype);
END //

DROP PROCEDURE IF EXISTS view_loan_requests//
CREATE PROCEDURE view_loan_requests(
    IN username VARCHAR(50)
)
BEGIN
    DECLARE branchid INT;

    -- Get the branch_id based on the manager's username
    SELECT branch_id INTO branchid
    FROM employee
    WHERE user_name = username AND position IN ('Manager', 'Head_Manager');

    -- Retrieve loan request records for the manager's branch
    SELECT
        request_id AS `Request ID`,
        customer_id AS `Customer ID`,
        loan_amount AS `Loan Amount`,
        loan_type AS `Loan Type`,
        is_approved AS `Is Approved`
    FROM loan_request
    WHERE branch_id = branchid;
END //

DROP PROCEDURE IF EXISTS approve_loan_request//
CREATE PROCEDURE approve_loan_request(
    IN username VARCHAR(50),
    IN requestid INT,
    IN isapproved BOOLEAN,
    IN duration INT
)
BEGIN
    DECLARE branchid INT;
    DECLARE customerid INT;
    DECLARE loanid INT;
    DECLARE accountnumber INT;
    DECLARE loanamount NUMERIC(8,2);

    -- Get the branch_id based on the manager's username
    SELECT branch_id INTO branchid
    FROM employee
    WHERE user_name = username AND position IN ('Manager', 'Head_Manager');

    -- Get the customer_id based on the request_id
    SELECT customer_id INTO customerid
    FROM loan_request
    WHERE request_id = requestid;

    -- Get the account_number based on the request_id
    SELECT account_number INTO accountnumber
    FROM loan_request
    WHERE request_id = requestid;

    -- Get the loan_amount based on the request_id
    SELECT loan_amount INTO loanamount
    FROM loan_request
    WHERE request_id = requestid;

    -- Update the loan request record
    UPDATE loan_request
    SET is_approved = isapproved
    WHERE request_id = requestid;

    -- Insert record into offline_loan table if approved
    IF isapproved THEN
        -- Insert record into loan table
        INSERT INTO loan (customer_id, account_number, branch_id, loan_type, loan_amount, sanction_date, final_payment_date)
        VALUES (customerid, accountnumber, branchid, (SELECT loan_type FROM loan_request WHERE request_id = requestid), loanamount, CURDATE(), DATE_ADD(CURDATE(), INTERVAL duration MONTH));

        -- Get the loan_id
        SELECT LAST_INSERT_ID() INTO loanid;

        -- Insert record into offline_loan table
        INSERT INTO offline_loan (loan_id, request_id)
        VALUES (loanid, requestid);

        -- Insert loan installments
        INSERT INTO loan_installment (loan_id, amount, due_date)
        VALUES (loanid, (SELECT loan_amount FROM loan_request WHERE request_id = requestid) / duration, DATE_ADD(CURDATE(), INTERVAL 1 MONTH));

        -- deposit the loan amount
        CALL deposit_loan_amount(accountnumber, loanamount);
    END IF;   
END //

DROP PROCEDURE IF EXISTS customer_applied_loan//
CREATE PROCEDURE customer_applied_loan(
    IN username VARCHAR(50),
    IN accountnumber INT,
    IN loanamount NUMERIC(8,2),
    IN loantype ENUM('Business', 'Personal'),
    IN duration INT
)
BEGIN
    DECLARE customerid INT;
    DECLARE branchid INT;
    DECLARE loanid INT;
    DECLARE fdno INT;

    -- Get customer_id and branch_id based on the username
    SELECT c.customer_id, a.branch_id INTO customerid, branchid
    FROM customer c
    JOIN account a ON c.customer_id = a.customer_id
    WHERE c.user_name = username;

    -- Insert record into loan table
    INSERT INTO loan (customer_id, account_number, branch_id, loan_type, loan_amount, sanction_date, final_payment_date)
    VALUES (customerid, accountnumber, branchid, loantype, loanamount, CURDATE(), DATE_ADD(CURDATE(), INTERVAL duration MONTH));

    -- Get the loan_id
    SELECT LAST_INSERT_ID() INTO loanid;

    -- Get the fd_no from the fd table using the savings account number of the customer
    SELECT fd_no INTO fdno
    FROM fd
    WHERE savings_account_number = accountnumber;

    -- Insert record into online_loan table
    INSERT INTO online_loan (loan_id, fd_no)
    VALUES (loanid, fdno);

    -- Insert loan installments
    INSERT INTO loan_installment (loan_id, amount, due_date)
    VALUES (loanid, loanamount / duration, DATE_ADD(CURDATE(), INTERVAL 1 MONTH));

    -- deposit the loan amount
    CALL deposit_loan_amount(accountnumber, loanamount);
END //

DROP PROCEDURE IF EXISTS update_loan_installment_payment_date//
CREATE PROCEDURE update_loan_installment_payment_date(
    IN loanid INT,
    IN duedate DATE
)
BEGIN
    -- Update the payment date
    UPDATE loan_installment
    SET payment_date = CURDATE()
    WHERE loan_id = loanid AND due_date = duedate;

    -- Delete the loan arrears record
    CALL add_remove_loan_arrears(loanid, duedate, 0);
END //

DROP PROCEDURE IF EXISTS view_unpaid_loan_installments//
CREATE PROCEDURE view_unpaid_loan_installments(
    IN username VARCHAR(50)
)
BEGIN
    DECLARE branchid INT;

    -- Get the branch_id based on the employee's username
    SELECT branch_id INTO branchid
    FROM employee
    WHERE user_name = username;

    -- Retrieve loan installments that are not paid
    SELECT
        l.loan_id AS `Loan ID`,
        l.account_number AS `Account Number`,
        li.due_date AS `Due Date`
    FROM loan l
    JOIN loan_installment li ON l.loan_id = li.loan_id
    WHERE l.branch_id = branchid AND li.payment_date IS NULL;
END //

DROP PROCEDURE IF EXISTS customer_view_loan_details//
CREATE PROCEDURE customer_view_loan_details(
    IN username VARCHAR(50)
)
BEGIN
    DECLARE customerid INT;

    -- Get the customer_id based on the username
    SELECT customer_id INTO customerid
    FROM customer
    WHERE user_name = username;

    -- Retrieve loan installment details for the customer
    SELECT
        l.loan_id AS `Loan ID`,
        l.account_number AS `Account Number`,
        li.due_date AS `Due Date`,
        li.amount AS `Amount`,
        li.payment_date AS `Payment Date`
    FROM loan l
    JOIN loan_installment li ON l.loan_id = li.loan_id
    WHERE l.customer_id = customerid;
END //

DROP PROCEDURE IF EXISTS deposit_loan_amount//
CREATE PROCEDURE deposit_loan_amount(
    IN accountnumber INT,
    IN loanamount NUMERIC(8,2)
)
BEGIN
    DECLARE transactionid INT;

    -- Insert record into transaction table
    INSERT INTO transaction (amount, transaction_type, description, time_stamp)
    VALUES (loanamount, 'Deposit', 'Loan Sanctioned', NOW());

    -- Get the transaction_id
    SELECT LAST_INSERT_ID() INTO transactionid;

    -- Insert record into deposit table
    INSERT INTO deposit (transaction_id, account_number)
    VALUES (transactionid, accountnumber);
END //

DROP PROCEDURE IF EXISTS get_account_details//
CREATE PROCEDURE get_account_details(
    IN username VARCHAR(50)
)
BEGIN
    SELECT
        `Account Number`,
        `Customer ID`,
        `Customer Type`,
        `Customer Name`,
        `Branch ID`,
        `Branch Name`,
        `Balance`,
        `Open Date`,
        `Account Status`,
        `Account Type`,
        `Savings Plan Type`,
        `Interest Rate`,
        next_calculation_on AS `Next Calculation On`
    FROM account_details_view
    WHERE `User Name` = username;
END //

-- automated procedures

DROP PROCEDURE IF EXISTS add_remove_loan_arrears//
CREATE PROCEDURE add_remove_loan_arrears(
    IN loanid INT,
    IN duedate DATE,
    IN isinsert BOOLEAN
)
BEGIN
    IF isinsert THEN
        -- Insert record into loan arrears table
        INSERT INTO loan_arrears (loan_id, amount)
        VALUES (loanid, (SELECT amount
                        FROM loan_installment
                        WHERE loan_id = loanid AND due_date = duedate));
    ELSE
        -- Delete record from loan arrears table
        DELETE la FROM loan_arrears la
        JOIN loan_installment li ON la.loan_id = li.loan_id
        WHERE la.loan_id = loanid AND li.due_date = duedate;
    END IF;
END //

DROP PROCEDURE IF EXISTS add_monthly_interest_deposit//
CREATE PROCEDURE add_monthly_interest_deposit(
    IN accountnumber INT
)
BEGIN
    DECLARE interestrate NUMERIC(4,2);
    DECLARE interestamount NUMERIC(10,2);
    DECLARE transactionid INT;

    -- Get the interest rate for the account
    SELECT interest_rate INTO interestrate
    FROM savings_plan
    WHERE savings_plan_type = (SELECT savings_plan_type
                                FROM savings_account
                                WHERE account_number = accountnumber);

    -- Calculate the interest amount
    SELECT balance * (interestrate / 12) INTO interestamount
    FROM account
    WHERE account_number = accountnumber;

    -- Insert record into transaction table
    INSERT INTO transaction (amount, transaction_type, description, time_stamp)
    VALUES (interestamount, 'Deposit', 'Monthly interest', NOW());

    -- Get the transaction_id
    SELECT LAST_INSERT_ID() INTO transactionid;

    -- Insert record into deposit table
    INSERT INTO deposit (transaction_id, account_number)
    VALUES (transactionid, accountnumber);

    -- Update the next calculation date
    UPDATE savings_account
    SET next_calculation_on = DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
    WHERE account_number = accountnumber;
END //

DROP PROCEDURE IF EXISTS add_fd_interest_deposit//
CREATE PROCEDURE add_fd_interest_deposit(
    IN fdno INT
)
BEGIN
    DECLARE interestrate NUMERIC(4,2);
    DECLARE interestamount NUMERIC(10,2);
    DECLARE transactionid INT;
    DECLARE accountnumber INT;

    -- Get the interest rate for the fd
    SELECT interest_rate INTO interestrate
    FROM fd_plan
    WHERE fd_plan_id = (SELECT fd_plan_id
                            FROM fd
                            WHERE fd_no = fdno);

    -- Get the account number for the fd
    SELECT savings_account_number INTO accountnumber
    FROM fd
    WHERE fd_no = fdno;

    -- Calculate the interest amount
    SELECT balance * (interestrate / 12) INTO interestamount
    FROM account
    WHERE account_number = accountnumber;

    -- Insert record into transaction table
    INSERT INTO transaction (amount, transaction_type, description, time_stamp)
    VALUES (interestamount, 'Deposit', 'FD interest', NOW());

    -- Get the transaction_id
    SELECT LAST_INSERT_ID() INTO transactionid;

    -- Insert record into deposit table
    INSERT INTO deposit (transaction_id, account_number)
    VALUES (transactionid, accountnumber);

    -- Update the next interest deposit date until maturity date and if the maturity date is today, update the next interest deposit date to null
    UPDATE fd
    SET next_interest_deposit_date = CASE
                                        WHEN maturity_date = CURDATE() THEN NULL
                                        ELSE DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
                                     END
    WHERE fd_no = fdno;    
END //

DROP PROCEDURE IF EXISTS add_loan_installment//
CREATE PROCEDURE add_loan_installment(
    IN loanid INT,
    IN duedate DATE
)
BEGIN
    -- Insert record into loan installment table
    INSERT INTO loan_installment (loan_id, amount, due_date)
    VALUES (loanid, (SELECT loan_amount
                    FROM loan
                    WHERE loan_id = loanid) / (SELECT TIMESTAMPDIFF(MONTH, sanction_date, final_payment_date)
                                                FROM loan
                                                WHERE loan_id = loanid), duedate);
END //

DELIMITER ;
