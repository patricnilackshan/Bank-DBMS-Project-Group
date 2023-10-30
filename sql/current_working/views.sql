SET foreign_key_checks = 0;


--
-- Views
--

DROP VIEW IF EXISTS customer_details_view;
CREATE VIEW customer_details_view AS
SELECT
    c.customer_id AS `Customer ID`,
    c.customer_type AS `Customer Type`,
    wpu.user_name AS `User Name`,
    CASE
        WHEN c.customer_type = 'Individual' THEN CONCAT(i.first_name, ' ', i.last_name)
        WHEN c.customer_type = 'Organization' THEN o.name
        ELSE NULL
    END AS `Customer Name`,
    CASE
        WHEN c.customer_type = 'Individual' THEN i.nic
        WHEN c.customer_type = 'Organization' THEN o.organization_reg_no
        ELSE NULL
    END AS `Customer NIC/Reg No`,
    i.date_of_birth AS `Date of Birth`,
    i.gender AS `Gender`,
    CASE
        WHEN c.customer_type = 'Individual' THEN i.address
        WHEN c.customer_type = 'Organization' THEN o.address
        ELSE NULL
    END AS `Address`,
    wpu.email_address AS `Email Address`,
    CASE
        WHEN c.customer_type = 'Individual' THEN i.contact_number
        WHEN c.customer_type = 'Organization' THEN o.contact_number
        ELSE NULL
    END AS `Contact Number`
FROM customer c
LEFT JOIN web_platform_user wpu ON c.user_name = wpu.user_name
LEFT JOIN individual i ON c.customer_id = i.customer_id
LEFT JOIN organization o ON c.customer_id = o.customer_id;


DROP VIEW IF EXISTS employee_details_view;
CREATE VIEW employee_details_view AS
SELECT
    e.employee_id AS `Employee ID`,
    wpu.user_name AS `User Name`,
    CONCAT(e.first_name, ' ', e.last_name) AS `Employee Name`,
    e.date_of_birth AS `Date of Birth`,
    e.gender AS `Gender`,
    e.address AS `Address`,
    wpu.email_address AS `Email Address`,
    e.contact_number AS `Contact Number`,
    e.position AS `Position`,
    e.salary AS `Salary`,
    b.branch_name AS `Branch Name`,
    e.status AS `Status`
FROM employee e
JOIN web_platform_user wpu ON e.user_name = wpu.user_name
JOIN branch b ON e.branch_id = b.branch_id;


DROP VIEW IF EXISTS account_details_view;
CREATE VIEW account_details_view AS
SELECT
    a.account_number AS `Account Number`,
    c.customer_id AS `Customer ID`,
    c.customer_type AS `Customer Type`,
    wpu.user_name AS `User Name`,
    CASE
        WHEN c.customer_type = 'Individual' THEN CONCAT(i.first_name, ' ', i.last_name)
        WHEN c.customer_type = 'Organization' THEN o.name
        ELSE NULL
    END AS `Customer Name`,
    a.branch_id AS `Branch ID`,
    b.branch_name AS `Branch Name`,
    a.balance AS `Balance`,
    a.open_date AS `Open Date`,
    a.account_status AS `Account Status`,
    a.account_type AS `Account Type`,
    s.savings_plan_type AS `Savings Plan Type`,
    s.next_calculation_on AS next_calculation_on,
    sp.interest_rate AS `Interest Rate`
FROM account a
JOIN customer c ON a.customer_id = c.customer_id
LEFT JOIN web_platform_user wpu ON c.user_name = wpu.user_name
LEFT JOIN individual i ON c.customer_id = i.customer_id
LEFT JOIN organization o ON c.customer_id = o.customer_id
JOIN branch b ON a.branch_id = b.branch_id
LEFT JOIN savings_account s ON a.account_number = s.account_number
LEFT JOIN savings_plan sp ON s.savings_plan_type = sp.savings_plan_type;


DROP VIEW IF EXISTS transactions_details_view;
CREATE VIEW transactions_details_view AS
SELECT
    t.transaction_id AS `Transaction ID`,
    t.transaction_type AS `Transaction Type`,
    t.description AS `Description`,
    t.amount AS `Amount`,
    t.time_stamp AS `Time Stamp`,
    CASE
    	WHEN t.transaction_type = 'Deposit' THEN d.account_number
        WHEN t.transaction_type = 'Withdrawal' THEN w.account_number
    END AS `Account Number`,
    a.branch_id AS `Branch ID`,
    b.branch_name AS `Branch Name`,
    c.customer_id AS `Customer ID`,
    CASE
        WHEN c.customer_type = 'Individual' THEN CONCAT(i.first_name, ' ', i.last_name)
        WHEN c.customer_type = 'Organization' THEN o.name
        ELSE NULL
    END AS `Customer Name`
FROM transaction t
LEFT JOIN deposit d ON t.transaction_id = d.transaction_id AND t.transaction_type = 'Deposit'
LEFT JOIN withdrawal w ON t.transaction_id = w.transaction_id AND t.transaction_type = 'Withdrawal'
LEFT JOIN account a ON (
    (t.transaction_type = 'Deposit' AND d.account_number = a.account_number)
    OR
    (t.transaction_type = 'Withdrawal' AND w.account_number = a.account_number)
)
JOIN branch b ON a.branch_id = b.branch_id
JOIN customer c ON a.customer_id = c.customer_id
LEFT JOIN individual i ON c.customer_id = i.customer_id
LEFT JOIN organization o ON c.customer_id = o.customer_id;


DROP VIEW IF EXISTS loan_installments_view;
CREATE VIEW loan_installments_view AS
SELECT
    l.loan_id AS `Loan ID`,
    l.account_number AS `Account Number`,
    l.branch_id AS `Branch ID`,
    b.branch_name AS `Branch Name`,
    c.customer_id AS `Customer ID`,
    CASE
        WHEN c.customer_type = 'Individual' THEN CONCAT(i.first_name, ' ', i.last_name)
        WHEN c.customer_type = 'Organization' THEN o.name
        ELSE NULL
    END AS `Customer Name`,
    li.due_date AS `Due Date`,
    li.amount AS `Amount`,
    li.payment_date AS `Payment Date`,
    CASE
        WHEN li.payment_date IS NULL AND li.due_date < CURDATE() THEN 'Overdue'
        WHEN li.payment_date IS NULL AND li.due_date >= CURDATE() THEN 'Pending'
        WHEN li.payment_date IS NOT NULL AND li.due_date < li.payment_date THEN 'Late'
        ELSE 'Paid'
    END AS `Status`
FROM loan l
JOIN branch b ON l.branch_id = b.branch_id
JOIN customer c ON l.customer_id = c.customer_id
LEFT JOIN individual i ON c.customer_id = i.customer_id
LEFT JOIN organization o ON c.customer_id = o.customer_id
JOIN loan_installment li ON l.loan_id = li.loan_id;


SET foreign_key_checks = 0;
