SET foreign_key_checks = 0;


-- Creating the database
DROP DATABASE IF EXISTS bank_data;
CREATE DATABASE bank_data;
USE bank_data;


--
-- Tables
--

DROP TABLE IF EXISTS web_platform_user;
CREATE TABLE web_platform_user (
    user_name varchar(50) NOT NULL,
    password_hash varchar(255),
    email_address varchar(50) NOT NULL UNIQUE,
    last_login datetime NOT NULL,
    PRIMARY KEY (user_name)
);

DROP TABLE IF EXISTS branch;
CREATE TABLE branch (
    branch_id int UNSIGNED NOT NULL AUTO_INCREMENT,
    branch_name varchar(127) NOT NULL UNIQUE,
    hotline varchar(10) NOT NULL UNIQUE,
    address varchar(255) NOT NULL UNIQUE,
    email varchar(50) NOT NULL UNIQUE,
    PRIMARY KEY (branch_id)
);

DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    employee_id int UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name varchar(40) NOT NULL,
    last_name varchar(40) NOT NULL,
    branch_id int UNSIGNED NOT NULL,
    nic varchar(12) NOT NULL UNIQUE,
    contact_number varchar(10) NOT NULL,
    address varchar(255) NOT NULL,
    date_of_birth date NOT NULL,
    gender enum('M', 'F') NOT NULL,
    user_name varchar(50) NOT NULL UNIQUE,
    position enum('Head_Manager', 'Manager', 'Staff'),
    salary numeric(10,2),
    status enum('Active', 'Retired') NOT NULL DEFAULT 'Active',
    PRIMARY KEY (employee_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (user_name) REFERENCES web_platform_user(user_name)
);

DROP TABLE IF EXISTS branch_manager;
CREATE TABLE branch_manager (
    branch_id int UNSIGNED NOT NULL,
    manager_id int UNSIGNED NOT NULL,
    PRIMARY KEY (branch_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (manager_id) REFERENCES employee(employee_id)
);

DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    customer_id int UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_type enum('Individual', 'Organization') NOT NULL,
    user_name varchar(50) NOT NULL UNIQUE,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (user_name) REFERENCES web_platform_user(user_name)
);

DROP TABLE IF EXISTS individual;
CREATE TABLE individual (
    customer_id int UNSIGNED NOT NULL UNIQUE,
    first_name varchar(40) NOT NULL,
    last_name varchar(40),
    nic varchar(12) NOT NULL,
    contact_number varchar(10) NOT NULL,
    address varchar(255) NOT NULL,
    date_of_birth date NOT NULL,
    gender enum('M', 'F') NOT NULL,
    PRIMARY KEY (nic),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

DROP TABLE IF EXISTS organization;
CREATE TABLE organization (
    customer_id int UNSIGNED NOT NULL,
    organization_reg_no int NOT NULL,
    name varchar(40) NOT NULL,
    contact_number varchar(10) NOT NULL,
    address varchar(255) NOT NULL,
    PRIMARY KEY (organization_reg_no),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

DROP TABLE IF EXISTS organization_individual;
CREATE TABLE organization_individual (
    organization_reg_no int NOT NULL,
    customer_id int UNSIGNED NOT NULL UNIQUE,
    position varchar(50) NOT NULL,
    PRIMARY KEY (organization_reg_no, customer_id),
    FOREIGN KEY (organization_reg_no) REFERENCES organization(organization_reg_no),
    FOREIGN KEY (customer_id) REFERENCES individual(customer_id)
);

DROP TABLE IF EXISTS account;
CREATE TABLE account (
    account_number int NOT NULL,
    customer_id int UNSIGNED NOT NULL,
    branch_id int UNSIGNED NOT NULL,
    balance numeric(10,2) NOT NULL,
    open_date date NOT NULL,
    account_status enum('Active', 'Suspended', 'Closed') NOT NULL DEFAULT 'Active',
    account_type enum('Saving', 'Checking') NOT NULL,
    number_of_withdrawals int NOT NULL DEFAULT 0,
    PRIMARY KEY (account_number),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

DROP TABLE IF EXISTS saving_plan;
CREATE TABLE savings_plan (
    savings_plan_type enum('Children', 'Teen', 'Adult', 'Senior') NOT NULL, 
    interest_rate numeric(4,2) NOT NULL,
    minimum_deposit numeric(6,2) NOT NULL,
    max_withdrawals int NOT NULL DEFAULT 5,
    PRIMARY KEY (savings_plan_type)
);

DROP TABLE IF EXISTS savings_account;
CREATE TABLE savings_account (
    account_number int NOT NULL,
    next_calculation_on date,
    savings_plan_type enum('Children', 'Teen', 'Adult', 'Senior') NOT NULL,
    PRIMARY KEY (account_number),
    FOREIGN KEY (account_number) REFERENCES account(account_number),
    FOREIGN KEY (savings_plan_type) REFERENCES savings_plan(savings_plan_type)
);

DROP TABLE IF EXISTS checking_account;
CREATE TABLE checking_account (
    account_number int NOT NULL,
    PRIMARY KEY (account_number),
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);

DROP TABLE IF EXISTS fd_plan;
CREATE TABLE fd_plan (
    fd_plan_id int NOT NULL,
    interest_rate numeric(4,2) NOT NULL,
    duration_in_months int NOT NULL,
    PRIMARY KEY (fd_plan_id)
);

DROP TABLE IF EXISTS fd;
CREATE TABLE fd (
    fd_no int NOT NULL AUTO_INCREMENT,
    fd_plan_id int NOT NULL,
    savings_account_number int NOT NULL,
    branch_id int UNSIGNED NOT NULL,
    deposit_date date NOT NULL,
    next_interest_deposit_date date,
    amount numeric(10,2) NOT NULL,
    fd_status enum('Active', 'Matured', 'Withdrawn') NOT NULL,
    maturity_date date NOT NULL,
    PRIMARY KEY (fd_no),
    FOREIGN KEY (fd_plan_id) REFERENCES fd_plan(fd_plan_id),
    FOREIGN KEY (savings_account_number) REFERENCES savings_account(account_number),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

DROP TABLE IF EXISTS transaction;
CREATE TABLE transaction (
    transaction_id int NOT NULL AUTO_INCREMENT,
    amount numeric(8,2) NOT NULL,
    transaction_type enum('Deposit', 'Withdrawal') NOT NULL,
    description text,
    time_stamp datetime NOT NULL,
    PRIMARY KEY (transaction_id)
);

DROP TABLE IF EXISTS deposit;
CREATE TABLE deposit (
    transaction_id int NOT NULL,
    account_number int NOT NULL,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id),
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);

DROP TABLE IF EXISTS withdrawal;
CREATE TABLE withdrawal (
    transaction_id int NOT NULL,
    account_number int NOT NULL,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id),
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);

DROP TABLE IF EXISTS loan;
CREATE TABLE loan (
    loan_id int NOT NULL AUTO_INCREMENT,
    customer_id int UNSIGNED NOT NULL,
    account_number int NOT NULL,
    branch_id int UNSIGNED NOT NULL,
    loan_type enum('Business', 'Personal') NOT NULL,
    loan_amount numeric(8,2) NOT NULL,
    sanction_date date NOT NULL,
    final_payment_date date,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);

DROP TABLE IF EXISTS online_loan;
CREATE TABLE online_loan (
    loan_id int NOT NULL,
    fd_no int NOT NULL,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (loan_id) REFERENCES loan(loan_id),
    FOREIGN KEY (fd_no) REFERENCES fd(fd_no)
);

DROP TABLE IF EXISTS loan_request;
CREATE TABLE loan_request (
    request_id int NOT NULL AUTO_INCREMENT,
    customer_id int UNSIGNED NOT NULL,
    account_number int NOT NULL,
    branch_id int UNSIGNED NOT NULL,
    is_approved boolean NOT NULL DEFAULT FALSE,
    loan_amount numeric(8,2) NOT NULL,
    loan_type enum('Business', 'Personal') NOT NULL,
    PRIMARY KEY (request_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);

DROP TABLE IF EXISTS offline_loan;
CREATE TABLE offline_loan (
    loan_id int NOT NULL,
    request_id int NOT NULL,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (loan_id) REFERENCES loan(loan_id),
    FOREIGN KEY (request_id) REFERENCES loan_request(request_id)
);

DROP TABLE IF EXISTS loan_installment;
CREATE TABLE loan_installment (
    loan_id int NOT NULL,
    amount numeric(7,2) NOT NULL,
    due_date date NOT NULL,
    payment_date date,
    PRIMARY KEY (loan_id, due_date),
    FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);

DROP TABLE IF EXISTS loan_arrears;
CREATE TABLE loan_arrears (
    loan_id int NOT NULL,
    arrear_amount numeric(7,2) NOT NULL,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);

DROP TABLE IF EXISTS report;
CREATE TABLE report (
    report_id int NOT NULL AUTO_INCREMENT,
    report_type enum('Transaction Report','Loan Installment Report') NOT NULL,
    time_stamp datetime NOT NULL,
    manager_id int UNSIGNED NOT NULL,
    PRIMARY KEY (report_id),
    FOREIGN KEY (manager_id) REFERENCES employee(employee_id)
);

--
-- Dumping data 
--

INSERT INTO web_platform_user VALUES
  ('BR02M1','$2b$10$fzu2c2dzsis5Qzob81VdcOv3qXd3SHqLN7/d06/5vcEDaUTdPrdPK', 'elensmith@yahoo.com', '2023-10-20 21:23:00'),
  ('BR01M1','$2b$10$7V4C/c8SHvvoigr/ItFFTOL9/qL1.kMm.APdbkN2peqelh1zIY7Q6', 'peterparker@gmail.com', '2023-10-15 09:23:55'),
  ('BR01M2','$2b$10$WQFv.pzpP.CiZNZPbmv01uAWpcFOsMlBLXtVoO3keY.RPjt4B035W', 'jadewarner@gmail.com', '2023-10-18 20:42:55'),
  ('BR03M1','$2b$10$QyLg/ZGS0SlmxCjnY.G4o.PEV1W.qykfpa6vueP8FgGhheJF4Jev6', 'nancywhite@gmail.com', '2023-10-24 06:23:02'),
  ('BR04M1','$2b$10$wxorL7ZDUy8/dJs4Ogk24OAN0zN3UN0ne3wRDHltj8nZ0Pj.LywHS', 'lucastaylor@gmail.com', '2023-10-09 13:42:30'),
  ('BR03M2','$2b$10$42EPP//pW8k2NIKCv1SwZOiqJ5.nusSLJ8B5/w4AfaL1sWBoky5GC', 'markjohnson@gmail.com', '2023-10-28 18:23:40'),
  ('BR05M1','$2b$10$JDJOm6djZe3GrtEvFMfRgeqVz9pSTv4V6DGSAJRHgyLx.wp3T4vZy', 'lilywillstone@gmail.com', '2023-10-04 22:31:55'),
  ('BR05M2','$2b$10$BWU2KLRm2sxKeu.N27biVO6L6PO6nmy/5C8aL8XhhvDNpOYGqEKA2', 'stevenroot@gmail.com', '2023-10-15 23:23:30'),
  ('BR05M3','$2b$10$pB6Dv2E.wxwtCNwuDKtvNex0ulVCmjbwEyqLVlwTNP7Ymy65GJsKS', 'alliewilliamson@gmail.com', '2023-10-12 07:52:55'),
  ('BR02M2','$2b$10$XTrbkIVqur9VsklRayzHD.mxpsP5COHJFuuQ1ym6zLwFXDYQPQUci', 'eloncummins@gmail.com', '2023-10-28 10:23:00'),
  ('BR02M3','$2b$10$C/WwzC2lLK5wZiAHpE37.e4cghZwuF6IZWGFH8JHCbEhLTqP.YAGW', 'maddywade@gmail.com', '2023-10-11 11:31:01'),
  ('BR03M3','$2b$10$iLWfa0e5MD1zcjQTbBCh3.wWxSueU8ITIWjopYBWMjzSpnroOAeB2', 'tomstark@gmail.com', '2023-10-08 12:42:40'),
  ('BR01M3','$2b$10$Kg48uwfYFmM0IpO/t3qkhee4W5qwnBzLnxUhoSs1gFsJxy6UdePqq', 'drakebrook@gmail.com', '2023-10-20 09:20:55'),
  ('BR04M2','$2b$10$k8ImAR4.r2wkpyB8VopPcec6RnmpIU.Oo6Rwq50584.ZywxogxjbG', 'felixevens@gmail.com', '2023-10-15 09:23:35'),
  ('AB2001','$2b$10$l2HOrIIAWdgNphsjHgoMfe9XyynTRK16PrtJmdoESNsVxjlp5u90.', 'johnnybrown@gmail.com', '2023-10-15 09:23:35'),
  ('PCR002','$2b$10$bna3yhXvHq6cD4iEGmGJv.tbQJZLabnnnLdJ61jlA3N0cTJ1ZL6u6', 'catalyst@gmail.com', '2023-10-15 09:23:35'),
  ('GTA562','$2b$10$N3pa7TS5OBlFazs.13IMLe2O3VYjEq6OqORbA3bdmgFf47/.hAh.K', 'alicesmith@gmail.com', '2023-10-30 13:50:35'),
  ('129AC56','$2b$10$MlK/t1ORGdxkxLP3gJbk5uls76/nUmztR64jbpMgqNWEJkDS1ngZG', 'jamesmiller@gmail.com', '2023-10-23 23:23:35'),
  ('PLC5600','$2b$10$3kXSJoXHmKFQaYQXIPFa1O/7Ud4740FC2Dc/J4s761A4EMX.PkAEK', 'avawilliams@gmail.com', '2023-10-15 09:45:35'),
  ('0012GB','$2b$10$aoVYhjyFJc1lINuDMmM2oOgi21xD4pTYs2o.L15hDkO7JwrxXhV8S', 'lucasmartinez@gmail.com', '2023-10-21 06:22:35'),
  ('LN2453','$2b$10$H1yhSkr7LIsvRhO/4JLP6eLmKUkYpXkyIH4DT2NQJHOFIwBcabg4i', 'nexusltd@gmail.com', '2023-10-17 09:34:35'),
  ('KGP02','$2b$10$plxkJmtPh6hvAqguYquCbel2w1vGk7sG3q48E5NqN3ny91.qZbxeO', 'robloxcoop@gmail.com', '2023-10-15 10:42:35'),
  ('29300L','$2b$10$.IxXivjiHnKRh1CUvrnUaeZWq44L5xQqhkEVMza3wN7l7HKZKUv.O', 'michaeljohnson@gmail.com', '2023-09-15 11:23:55'),
  ('D34200','$2b$10$kKoGqjokoEWI1znuAIRYM.9lsveCf6IOiBv.6MTw9kBBCNERjeu2u', 'ameliawhite@gmail.com', '2023-10-15 12:39:35'),
  ('98000F','$2b$10$KXUycbW3XI1r7uZksOmqeuXPlpwLg04jnAYhY4iNm7hpeXw9spGIO', 'williamssons@gmail.com', '2023-10-08 07:40:23'),
  ('X000FX','$2b$10$v/NXrfLHso5OEQT7X85J0udkPQ1PT2tUpjRjc8n6AbjPRGHsWKYOi', 'benjamintaylor@gmail.com', '2023-10-23 09:23:49'),
  ('F112U2','$2b$10$Zp989kwOuBiyMGmsTgs6Ju0vE9QMbJw8PlMwtwFFleYm6JeQDSwdy', 'johndoe@gmail.com', '2023-10-15 09:23:35'),
  ('L0P123','$2b$10$d0W/rPuFmm3fDIPq0ygIAuQtdAcahl10HUoQ2vtYiURovr3i3nJW.', 'loganmartinez@gmail.com', '2023-04-14 04:56:23'),
  ('R2D2C3','$2b$10$jSOLWlVRtplKeVfkRGO0uOJdkrSdg6ghUJvEZ9Kd/66QTymxYRqPm', 'drakeco@gmail.com', '2023-08-19 10:45:35'),
  ('BD3200','$2b$10$oR0dIzojI86vY9LMkzyMZu2j5ZaLkDUBCFO4TveQYUQRrs9bj7/1u', 'jimmywilliams@gmail.com', '2023-06-15 11:28:35'),
  ('JH78Y49','$2b$10$Vhgj1TX2pKVYhChhICPoXOSTdUlO8PONysGTjpp8bZOuxRLMTjmKC', 'annemiller@gmail.com', '2023-10-17 09:46:56'),
  ('00H2P3','$2b$10$6NpSkGAh6FNt8j1Zo6638.GJ2CQas.8g.WvrJNWcHdRpdiYMX9Gv6', 
'alicejones@gmail.com', 
'2023-11-28 13:15:45'),
('admin',
"$2b$10$o9ZaqokwN4eBEjDjWYD7/uRCWFl/.CHbz4ykdTHFaLyzUzJoB1QaK",
'admin@gmail.com',
'2023-11-01 01:10:20'
);
-- admin password == "password"

INSERT INTO branch VALUES
  (1001, 'Anse Boileau', '1234567890', '123, Main Street, Anse Boileau, Seychelles', 'anseboileau@abank.com'),
  (1002, 'Glacis', '9876543210', '456, Elm Street, Glacis, Seychelles', 'glacis@abank.com'),
  (1003, 'Plaisance', '3456789012', '789, Oak Street, Plaisance, Seychelles ', 'plaisance@abank.com'),
  (1004, 'Takamaka', '7890123456', '1011, Maple Street, Takamaka, Seychelles', 'takamaka@abank.com'),
  (1005, 'Victoria', '5678901234', '1213, Pine Street, Victoria, Seychelles', 'victoria@abank.com'); 

-- Position and salary are NULL if the employee is retired.
INSERT INTO employee VALUES
  (4001, 'Peter', 'Parker', 1001, '87681006780V', '0662300931', 'Victoria, Seychelles, 10010', '1997-08-29', 'M', 'BR01M1','Head_Manager', 70000.00, 'Active'),
  (4002, 'Elen', 'Smith', 1002, '90028293749V', '0679200000', 'Providence Atoll, Seychelles, 19942', '1985-12-20', 'F', 'BR02M1','Manager', 60000.00, 'Active' ),
  (4003, 'Jade', 'Warner', 1001, '30003268394V', '0662200003', 'Cosmoledo Atoll, Seychelles, 24542', '1980-03-10', 'M', 'BR01M2','Manager', 65000.00, 'Active'),
  (4004, 'Nancy', 'White', 1003, '20037373827V', '0677000000', 'Astove Island, Seychelles, 47653', '1975-08-29', 'F', 'BR03M1','Manager', 100000.00, 'Active'),
  (4005, 'Lucas', 'Taylor', 1004,  '10107468239V', '0678844445', 'Alphonse Island, Seychelles, 19928', '1980-10-22', 'M', 'BR04M1','Manager', 85000.00, 'Active'),
  (4006, 'Mark', 'Johnson', 1003, '88000066219V', '0665444400', 'Desroches Island, Seychelles, 19922', '1983-08-25', 'M', 'BR03M2', NULL, NULL, 'Retired'),
  (4007, 'Lily', 'Willstone', 1005, '33000047620V', '0662444449', 'Denis Island, Seychelles, 16524', '1996-09-30', 'F', 'BR05M1','Manager', 75000.00, 'Active'),
  (4008, 'Steven', 'Root', 1005, '30004847620V', '0662435777', 'Astove Island, Seychelles, 45672', '1998-12-29', 'M', 'BR05M2','Staff', 40000.00, 'Active'),
  (4009, 'Allie', 'Willamson', 1005, '44444847620V', '0677735249', 'Providence Atoll, Seychelles, 19929', '1999-04-01', 'F', 'BR05M3','Staff', 55000.00, 'Active'),
  (4010, 'Elon', 'Cummins', 1002, '37272847620V', '0662477749', 'Denis Island, Seychelles, 16466', '2000-02-10', 'M', 'BR02M2','Staff', 30000.00, 'Active'),
  (4011, 'Maddy', 'Wade', 1002, '39922847620V', '0662435333', 'Alphonse Island, Seychelles, 13382', '1980-01-19', 'F', 'BR02M3','Staff', 40000.00, 'Active'),
  (4012, 'Tom', 'Stark', 1003, '33811117620V', '0662433339', 'Providence Atoll, Seychelles, 14490', '1988-09-24', 'M', 'BR03M3', NULL, NULL, 'Retired'),
  (4013, 'Drake', 'Brook', 1001, '33881111620V', '0662435222', 'Desroches Island, Seychelles, 24400', '1978-10-23', 'M', 'BR01M3','Staff', 52000.00, 'Active'),
  (4014, 'Felix', 'Evans', 1004, '23000006270V', '0672222200', 'Bird Island, Seychelles, 21880', '1985-01-03', 'M', 'BR04M2','Staff', 35000.00, 'Active');

INSERT INTO branch_manager VALUES (1001, 4001), (1002, 4002), (1003, 4004), (1004, 4005), (1005, 4007);

INSERT INTO customer VALUES
  (10001, 'Individual', 'AB2001'),
  (10002, 'Organization', 'PCR002'),
  (10003, 'Individual', 'GTA562'),
  (10004, 'Individual', '129AC56'),
  (10005, 'Individual', 'PLC5600'),
  (10006, 'Individual', '0012GB'),
  (10007, 'Organization', 'LN2453'),
  (10008, 'Organization', 'KGP02'),
  (10009, 'Individual', '29300L'),
  (10010, 'Individual', 'D34200'),
  (10011, 'Organization', '98000F'),
  (10012, 'Individual', 'X000FX'),
  (10013, 'Individual', 'F112U2'),
  (10014, 'Individual', '00H2P3'),
  (10015, 'Organization', 'R2D2C3'),
  (10016, 'Individual', 'BD3200'),
  (10017, 'Individual', 'JH78Y49'),
  (10018, 'Individual', 'L0P123');

INSERT INTO individual VALUES
  (10001, 'Johnny', 'Brown', '92381006780V', '0662375931', 'Victoria, Seychelles, 16112', '1940-08-29', 'M'),
  (10003, 'Alice', 'Smith', '43728293749V', '0679289429', 'Providence Atoll, Seychelles, 24190', '1983-10-20', 'F'),
  (10004, 'James', 'Miller', '98435268394V', '0662200003', 'Cosmoledo Atoll, Seychelles, 24180', '1930-04-10', 'M'),
  (10005, 'Ava', 'Williams', '19997373827V', '0677772000', 'Astove Island, Seychelles, 24170', '2004-08-15', 'F'),
  (10006, 'Lucas', 'Martinez', '23387468239V', '0672344445', 'Alphonse Island, Seychelles, 24160', '1980-10-22', 'M'),
  (10009, 'Michael', 'Johnson', '88236766219V', '0665550000', 'Desroches Island, Seychelles, 24150', '1980-08-25', 'M'),
  (10010, 'Amelia', 'White', '33884847620V', '0662435249', 'Denis Island, Seychelles, 24140', '1978-09-10', 'F'),
  (10012, 'Benjamin', 'Taylor', '23004726270V', '0672210000', 'Bird Island, Seychelles, 24139', '1959-01-03', 'M'),
  (10013, 'John', 'Doe', '99473728888V', '0662375930', 'Victoria, Seychelles, 12008', '2007-09-30', 'M'),
  (10014, 'Alice', 'Jones', '43738200050V', '0679289430', 'Providence Atoll, Seychelles, 24191', '1943-08-21', 'F'),
  (10016, 'Jimmy', 'Williams', '90000268395V', '0662200004', 'Cosmoledo Atoll, Seychelles, 24181', '1930-04-11', 'M'),
  (10017, 'Anne', 'Miller', '19030000828V', '0670072001', 'Astove Island, Seychelles, 24171', '2006-08-16', 'F'),
  (10018, 'Logan', 'Martinez', '20090468240V', '0672344446', 'Alphonse Island, Seychelles, 24161', '2018-10-23', 'M');

INSERT INTO organization VALUES
  (10002, 1000, 'Catalyst Pvt LTD', '0465323100', 'Catalyst Pvt LTD, Victoria, Seychelles'),
  (10007, 9300, 'The Nexus LTD', '0442838920', 'The Nexus, Alphonse Island, Seychelles'),
  (10008, 5400, 'Roblox Co-operation', '0463000200', 'Roblox Co-operation, Plaisance, Seychelles'),
  (10011, 3400, 'Williams and Sons', '0443627002', 'Williams and Sons, Glacis, Seychelles'),
  (10015, 5000, 'Drake and Co', '0463000200', 'Drake and Co, Takamaka, Seychelles');

INSERT INTO organization_individual VALUES
	(1000, 10005, 'Secretary'),
	(9300, 10018, 'Treasurer'),
	(5400, 10009, 'Leader'),
	(3400, 10014, 'Vice Secretary'),
	(5000, 10003, 'Treasurer');

INSERT INTO account VALUES 
  (2300021, 10001, 1001, 400000.00,'2016-11-11', 'Active', 'Saving', 3 ),
  (1002734, 10002, 1001, 50000.00,'2019-02-20', 'Active', 'Checking', 18 ),
  (6400028, 10003, 1003, 300000.00,'2017-07-11', 'Active', 'Saving', 1 ),
  (5000293, 10004, 1002, 103050.00,'2018-12-24', 'Active', 'Saving', 2 ),
  (9340000, 10005, 1001, 350750.00,'2020-04-11', 'Active', 'Saving', 3 ),
  (1837927, 10006, 1002, 100.00,'2020-08-04', 'Suspended', 'Checking', 3 ),
  (6400022, 10007, 1004, 250000.00,'2020-11-15', 'Active', 'Saving', 4 ),
  (7223913, 10008, 1003, 120000.00,'2020-12-31', 'Active', 'Checking', 14 ),
  (1234567, 10009, 1005, 1030500.00,'2021-05-11', 'Active', 'Checking', 7 ),
  (9876543, 10010, 1004, 0.00,'2021-06-23', 'Closed', 'Saving', 5 ),
  (6543210, 10011, 1001, 400750.00,'2021-11-09', 'Active', 'Saving', 0 ),
  (6003002, 10012, 1005, 1500000.00,'2022-09-11', 'Active', 'Saving', 4 ),
  (5000203, 10013, 1003, 0.00,'2022-08-29', 'Closed', 'Saving', 1 ),
  (2353647, 10014, 1003, 3500000.00,'2023-04-11', 'Active', 'Checking', 12 ),
  (2367647, 10015, 1001, 0.00,'2023-05-28', 'Closed', 'Saving', 2 ),
  (6059430, 10016, 1002, 2300000.00,'2023-06-29', 'Active', 'Checking', 1 ),
  (2234649, 10017, 1004, 750000.00,'2023-07-03', 'Active', 'Saving', 0 ),
  (2353560, 10018, 1005, 800000.00,'2023-08-04', 'Active', 'Saving', 2);

INSERT INTO savings_plan VALUES
  ('Senior', 0.13, 1000.00, 5),
  ('Adult', 0.10, 1000.00, 5),
  ('Teen', 0.11, 500.00, 5),
  ('Children', 0.12, 0.00, 5);

-- Next payment date is NULL if the account is suspended or closed.
INSERT INTO savings_account VALUES
  (2300021, '2023-11-11', 'Senior'),
  (6400028, '2023-11-11', 'Adult'),
  (5000293, '2023-11-24', 'Senior'),
  (9340000, '2023-11-11', 'Teen'),
  (6400022, '2023-11-11', 'Adult'),
  (9876543, NULL, 'Adult'),
  (6543210, '2023-11-09', 'Adult'),
  (6003002, '2023-11-11', 'Senior'),
  (5000203, NULL, 'Teen'),
  (2367647, NULL, 'Adult'),
  (2234649, '2023-11-03', 'Teen'),
  (2353560, '2023-11-04', 'Children');

INSERT INTO checking_account VALUES 
  (1002734),
  (1837927),
  (1234567),
  (7223913),
  (2353647),
  (6059430);

INSERT INTO fd_plan VALUES
  (7001, 0.13, 6),
  (7002, 0.14, 12),
  (7003, 0.15, 36);

INSERT INTO fd VALUES
  (123456, 1, 2300021, 1004, '2023-08-11', '2023-11-11', 1000000.00, 'Active', '2024-02-11'),
  (400050, 2, 5000293, 1001, '2022-05-20', NULL, 250000.00, 'Matured', '2023-05-20'),
  (983400, 3, 9340000, 1002, '2020-06-29', NULL, 3000000.00, 'Withdrawn', '2023-06-29'),
  (720043, 2, 6003002, 1005, '2023-04-05', '2023-11-05', 475000.00, 'Active', '2026-04-05'),
  (567229, 1, 6400028, 1003, '2023-10-01', '2023-11-01', 550000.00, 'Active', '2024-04-01');

INSERT INTO transaction VALUES
  (970001, 5000.00, 'Deposit', 'Mahapola', '2023-08-04 23:10:10'),
  (970002, 500.00, 'Deposit', 'Returning reload', '2021-05-30 10:08:40'),
  (970003, 1000.00, 'Withdrawal', 'Online Transfer', '2022-08-29 18:32:56'),
  (970004, 1000.00, 'Deposit', 'Online Transfer', '2022-08-29 18:32:56'),
  (970005, 650.00, 'Deposit', 'Monthly interest', '2023-10-01 12:46:10'),
  (970006, 400.00, 'Withdrawal', NULL, '2023-01-01 21:11:28'),
  (970007, 300.00, 'Withdrawal', 'Online Transfer', '2023-03-15 10:54:35'),
  (970008, 300.00, 'Deposit', 'Online Transfer', '2023-03-15 10:54:35'),
  (970009, 1400.00, 'Withdrawal', NULL, '2023-03-21 16:32:01'),
  (970010, 2500.00, 'Deposit', 'CDM Deposit', '2023-04-26 13:43:26'),
  (970011, 10000.00, 'Withdrawal', 'Online Transfer', '2023-07-29 14:45:47'),
  (970012, 10000.00, 'Deposit', 'Online Transfer', '2023-07-29 14:45:47'),
  (970013, 55000.00, 'Withdrawal', NULL, '2023-10-15 09:23:55'); 

INSERT INTO deposit VALUES
  (970001, 2300021),
  (970002, 6003002),
  (970004, 6003002),
  (970005, 6543210),
  (970008, 7223913),
  (970010, 9340000),
  (970012, 2300021); 

INSERT INTO withdrawal VALUES
  (970003, 5000293),
  (970006, 7223913),
  (970007, 2300021),
  (970009, 2353647),
  (970011, 6543210),
  (970013, 6003002); 

INSERT INTO loan VALUES
  (90001, 10004, 5000293, 1001, 'Personal', 100000.00, '2022-05-28', '2023-05-28' ),
  (90002, 10016, 6059430, 1005, 'Personal', 200000.00, '2022-06-30', '2023-06-30' ),
  (90003, 10002, 1002734, 1001, 'Business', 400000.00, '2023-07-03', '2026-07-03' ),
  (90004, 10017, 2234649, 1004, 'Personal', 200000.00, '2023-08-05', '2025-08-05' ),
  (90005, 10003, 6400028, 1002, 'Personal', 250000.00, '2023-08-14', '2024-08-14' ),
  (90006, 10001, 2300021, 1003, 'Personal', 400000.00, '2023-08-22', '2025-08-22' ),
  (90007, 10012, 6003002, 1005, 'Personal', 200000.00, '2023-09-15', '2026-09-15' ); 

INSERT INTO online_loan VALUES (90006, 123456), (90007, 720043);

INSERT INTO loan_request VALUES
  (70001, 10004, 5000293, 1001, TRUE, 100000.00, 'Personal'),
  (70002, 10009, 1234567, 1004, FALSE, 500000.00, 'Business'),
  (70003, 10016, 6059430, 1005, TRUE, 200000.00, 'Personal'),
  (70004, 10010, 9876543, 1003, FALSE, 300000.00, 'Personal'),
  (70005, 10002, 1002734, 1001, TRUE, 400000.00, 'Business'),
  (70006, 10007, 6400022, 1003, FALSE, 300000.00, 'Business'),
  (70007, 10017, 2234649, 1004, TRUE, 200000.00, 'Personal'),
  (70008, 10003, 6400028, 1002, TRUE, 250000.00, 'Personal');

INSERT INTO offline_loan VALUES
  (90001, 70001), (90002, 70003), (90003, 70005), (90004, 70007), (90005, 70008);

INSERT INTO loan_installment VALUES
  (90003, 11111.11, '2023-11-03', NULL),
  (90004, 8333.33, '2023-09-05', NULL),
  (90005, 20833.33, '2023-10-14', '2023-10-18'),
  (90006, 16666.66, '2023-09-22', NULL),
  (90007, 5555.55, '2023-10-15', '2023-10-14');

INSERT INTO loan_arrears VALUES (90004, 9228.99), (90006, 18457.97);

INSERT INTO report VALUES
  (30001, 'Transaction Report', '2023-09-29 14:45:24', 4001),
  (30002, 'Transaction Report', '2023-10-03 02:20:18', 4002),
  (30003, 'Transaction Report', '2023-10-24 08:38:15', 4004),
  (30004, 'Transaction Report', '2023-10-26 10:39:29', 4005),
  (30005, 'Transaction Report', '2023-10-28 13:18:38', 4007),
  (30006, 'Loan Installment Report', '2023-09-30 18:45:55', 4003),
  (30007, 'Loan Installment Report', '2023-09-30 14:10:41', 4002),
  (30008, 'Loan Installment Report', '2023-09-30 15:28:50', 4007),
  (30009, 'Loan Installment Report', '2023-09-30 09:37:20', 4005),
  (30010, 'Loan Installment Report', '2023-09-30 21:54:05', 4004),
  (30011, 'Transaction Report', '2023-07-29 14:43:47', 4004),
  (30012, 'Transaction Report', '2023-07-29 14:32:00', 4007),
  (30013, 'Transaction Report', '2023-07-29 14:21:41', 4005),
  (30014, 'Transaction Report', '2023-07-29 14:01:27', 4003),
  (30015, 'Transaction Report', '2023-07-29 14:25:01', 4002),
  (30016, 'Loan Installment Report', '2023-09-30 14:37:00', 4003);


--
-- Indices
--

CREATE INDEX idx_account_account_number ON account(account_number);
CREATE INDEX idx_savings_account_account_number ON web_platform_user(user_name);
CREATE INDEX idx_savings_account_savings_plan_type ON savings_account(savings_plan_type);
CREATE INDEX idx_manager_id ON branch_manager(manager_id);


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


--
-- Events
--

SET GLOBAL event_scheduler = ON;

DELIMITER //

DROP EVENT IF EXISTS update_loan_arrears//
CREATE EVENT update_loan_arrears
ON SCHEDULE EVERY 1 DAY STARTS '2023-10-01 00:00:00' ON COMPLETION PRESERVE DISABLE
DO
BEGIN
    DECLARE loanid INT;
    DECLARE duedate DATE;
    DECLARE done boolean DEFAULT FALSE;
    -- cursor for all the loan ids that has loan installments with null payment date and due date less than current date
    DECLARE loanid_curs CURSOR FOR SELECT loan_id, due_date FROM loan_installment WHERE payment_date IS NULL AND due_date < CURDATE();
    -- not found handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN loanid_curs;

    -- loop through the cursor and insert the loan id and the amount to the loan arrears table
    fetch_loan_id: LOOP
        FETCH loanid_curs INTO loanid, duedate;
        IF done THEN
            -- if no more rows to fetch, leave the loop
            LEAVE fetch_loan_id;
        END IF;
        CALL add_remove_loan_arrears(loanid, duedate, 1);
    END LOOP fetch_loan_id;

    CLOSE loanid_curs;
END //

DROP EVENT IF EXISTS deposit_interest//
CREATE EVENT deposit_interest
ON SCHEDULE EVERY 1 DAY STARTS '2023-10-01 00:00:00' ON COMPLETION PRESERVE DISABLE
DO
BEGIN
    DECLARE accountnumber INT;
    DECLARE done boolean DEFAULT FALSE;
    -- cursor for all the account numbers that has next calculation date as today
    DECLARE accountnumber_curs CURSOR FOR SELECT account_number FROM savings_account WHERE next_calculation_on = CURDATE();
    -- not found handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN accountnumber_curs;

    -- loop through the cursor and call the procedure add_monthly_interest_deposit with the account number as the parameter
    fetch_account_number: LOOP
        FETCH accountnumber_curs INTO accountnumber;
        IF done THEN
            -- if no more rows to fetch, leave the loop
            LEAVE fetch_account_number;
        END IF;
        CALL add_monthly_interest_deposit(accountnumber);
    END LOOP fetch_account_number;

    CLOSE accountnumber_curs;
END //

DROP EVENT IF EXISTS deposit_fd_interest//
CREATE EVENT deposit_fd_interest
ON SCHEDULE EVERY 1 DAY STARTS '2023-10-01 00:00:00' ON COMPLETION PRESERVE DISABLE
DO
BEGIN
    DECLARE fdno INT;
    DECLARE done boolean DEFAULT FALSE;
    -- cursor for every fd no that has next interest deposit date as today
    DECLARE fdno_curs CURSOR FOR SELECT fd_no FROM fd WHERE next_interest_deposit_date = CURDATE();
    -- not found handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN fdno_curs;

    -- loop through the cursor and call the procedure add_fd_interest_deposit with the fd no as the parameter
    fetch_fd_no: LOOP
        FETCH fdno_curs INTO fdno;
        IF done THEN
            -- if no more rows to fetch, leave the loop
            LEAVE fetch_fd_no;
        END IF;
        CALL add_fd_interest_deposit(fdno);
    END LOOP fetch_fd_no;

    CLOSE fdno_curs;
END //

DROP EVENT IF EXISTS update_loan_installment_table//
CREATE EVENT update_loan_installment_table
ON SCHEDULE EVERY 1 DAY STARTS '2023-10-01 00:00:00' ON COMPLETION PRESERVE DISABLE
DO
BEGIN
    DECLARE loanid INT;
    DECLARE duedate DATE;
    DECLARE done boolean DEFAULT FALSE;
    -- cursor for all the loan ids that has loan installments with null payment date and due date less than current date
    DECLARE loanid_curs CURSOR FOR SELECT loan_id, due_date FROM loan_installment WHERE due_date = CURDATE();
    -- not found handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN loanid_curs;

    -- loop through the cursor and insert the loan id and the amount to the loan arrears table
    fetch_loan_id: LOOP
        FETCH loanid_curs INTO loanid, duedate;
        IF done THEN
            -- if no more rows to fetch, leave the loop
            LEAVE fetch_loan_id;
        END IF;
        CALL add_loan_installment(loanid, DATE_ADD(duedate, INTERVAL 1 MONTH));
    END LOOP fetch_loan_id;

    CLOSE loanid_curs;
END //

DROP EVENT IF EXISTS reset_number_of_withdrawals//
CREATE EVENT reset_number_of_withdrawals
ON SCHEDULE EVERY 1 MONTH STARTS '2023-10-01 00:00:00' ON COMPLETION PRESERVE ENABLE
DO
BEGIN
    UPDATE savings_account
    SET number_of_withdrawals = 0;
END //

DELIMITER ;


--
-- Triggers
--

DELIMITER //

DROP TRIGGER IF EXISTS update_account_balance_after_deposit//
CREATE TRIGGER update_account_balance_after_deposit
AFTER INSERT ON deposit
FOR EACH ROW
BEGIN
    DECLARE deposit_amount NUMERIC(8,2);

    -- Get the deposited amount
    SELECT amount INTO deposit_amount
    FROM transaction
    WHERE transaction_id = NEW.transaction_id;

    -- Update the account balance
    UPDATE account
    SET balance = balance + deposit_amount
    WHERE account_number = NEW.account_number;
END //

DROP TRIGGER IF EXISTS update_account_balance_after_withdrawal//
CREATE TRIGGER update_account_balance_after_withdrawal
AFTER INSERT ON withdrawal
FOR EACH ROW
BEGIN
    DECLARE withdrawal_amount NUMERIC(8,2);

    -- Get the withdrewn amount
    SELECT amount INTO withdrawal_amount
    FROM transaction
    WHERE transaction_id = NEW.transaction_id;

    -- Update the account balance
    UPDATE account
    SET balance = balance - withdrawal_amount
    WHERE account_number = NEW.account_number;
END //


DELIMITER ;

COMMIT;


SET foreign_key_checks = 1;