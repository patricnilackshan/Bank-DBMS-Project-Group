SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,
    UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
    FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE,
    SQL_MODE = 'TRADITIONAL';

DROP DATABASE IF EXISTS bank_data;
CREATE DATABASE bank_data;
USE bank_data;

DROP TABLE IF EXISTS web_platform_user;
CREATE TABLE web_platform_user (
    user_name varchar(50) NOT NULL,
    password_hash varchar(255),
    email_address varchar(50) NOT NULL UNIQUE,
    last_login datetime NOT NULL,
    PRIMARY KEY (user_name)
);

DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
    `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `address_line_1` VARCHAR(50) NOT NULL,
    `address_line_2` VARCHAR(50),
    `city` VARCHAR(25) NOT NULL,
    `postal_code` MEDIUMINT UNSIGNED NOT NULL,
    PRIMARY KEY (address_id)
);

DROP TABLE IF EXISTS `branch`;
CREATE TABLE `branch` (
    `branch_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `branch_name` varchar(127) NOT NULL UNIQUE,
    -- `branch_type` enum('Head_Office', 'Branch') NOT NULL DEFAULT 'Branch',
    `hotline` varchar(10) NOT NULL UNIQUE,
    `address_id` int UNSIGNED NOT NULL UNIQUE,
    `email` varchar(50) NOT NULL UNIQUE,
    PRIMARY KEY (`branch_id`),
    FOREIGN KEY (`address_id`) REFERENCES `address`(`address_id`)
);

DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
    `employee_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `first_name` varchar(50) NOT NULL,
    `last_name` varchar(50),
    `branch_id` int UNSIGNED NOT NULL,
    `nic` varchar(12) NOT NULL UNIQUE,
    `contact_number` varchar(10) NOT NULL,
    `address_id` int UNSIGNED NOT NULL,
    `date_of_birth` date NOT NULL,
    `gender` enum('M', 'F', 'O') NOT NULL,
    `user_name` varchar(50) NOT NULL UNIQUE,
    `position` enum('Head_Mg', 'Manager', 'Staff'),
    `salary` numeric(7,2),
    `status` enum('Active', 'Retired') NOT NULL DEFAULT 'Active',
    PRIMARY KEY (`employee_id`),
    FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`),
    FOREIGN KEY (`user_name`) REFERENCES `web_platform_user`(`user_name`),
    FOREIGN KEY (`address_id`) REFERENCES `address`(`address_id`)
);

DROP TABLE IF EXISTS `branch_manager`;
CREATE TABLE `branch_manager` (
    `branch_id` int UNSIGNED NOT NULL,
    `manager_id` int UNSIGNED NOT NULL,
    PRIMARY KEY (`branch_id`),
    FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`),
    FOREIGN KEY (`manager_id`) REFERENCES `employee`(`employee_id`)
);

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
    `customer_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_type` enum('Individual', 'Organization') NOT NULL,
    `user_name` varchar(50) NOT NULL UNIQUE,
    PRIMARY KEY (`customer_id`),
    FOREIGN KEY (`user_name`) REFERENCES `web_platform_user`(`user_name`)
);

DROP TABLE IF EXISTS `individual`;
CREATE TABLE `individual` (
    `customer_id` int UNSIGNED NOT NULL,
    `first_name` varchar(40) NOT NULL,
    `last_name` varchar(40),
    `nic` varchar(12) NOT NULL UNIQUE,
    `contact_number` varchar(10) NOT NULL,
    `address_id` int UNSIGNED NOT NULL,
    `date_of_birth` date NOT NULL,
    `gender` enum('M', 'F', 'O') NOT NULL,
    PRIMARY KEY (`nic`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`),
    FOREIGN KEY (`address_id`) REFERENCES `address`(`address_id`)
);

DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
    `customer_id` int UNSIGNED NOT NULL,
    `organization_reg_no` int UNSIGNED NOT NULL,
    `name` varchar(40) NOT NULL,
    `contact_number` varchar(10) NOT NULL,
    `address_id` int UNSIGNED NOT NULL,
    PRIMARY KEY (`organization_reg_no`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`),
    FOREIGN KEY (`address_id`) REFERENCES `address`(`address_id`)
);

DROP TABLE IF EXISTS `organization_individual`;
CREATE TABLE `organization_individual` (
    `organization_reg_no` int UNSIGNED NOT NULL UNIQUE,
    `first_name` varchar(50) NOT NULL,
    `last_name` varchar(50),
    `nic` varchar(12) NOT NULL UNIQUE,
    `contact_number` varchar(10) NOT NULL,
    `gender` enum('M', 'F', 'O') NOT NULL,
    `date_of_birth` date NOT NULL,
    `address_id` int UNSIGNED NOT NULL,
    PRIMARY KEY (`nic`),
    FOREIGN KEY (`organization_reg_no`) REFERENCES `organization`(`organization_reg_no`),
    FOREIGN KEY (`address_id`) REFERENCES `address`(`address_id`)
);

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
    `account_number` int(16) ZEROFILL NOT NULL AUTO_INCREMENT,
    `customer_id` int UNSIGNED NOT NULL,
    `branch_id` int UNSIGNED NOT NULL,
    `balance` numeric(12, 2) CHECK (`balance` >= 0) NOT NULL,
    `open_date` date NOT NULL,
    `account_status` enum('Active', 'Suspended', 'Closed') NOT NULL DEFAULT 'Active',
    `account_type` enum('Saving', 'Checking') NOT NULL,
    `number_of_withdrawals` int NOT NULL DEFAULT 0,
    PRIMARY KEY (`account_number`),
    FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`)
);

DROP TABLE IF EXISTS `saving_plan`;
CREATE TABLE `savings_plan` (
    `savings_plan_type` enum('Children', 'Teen', 'Adult', 'Senior') NOT NULL,
    `interest` numeric(4, 2) NOT NULL,
    `minimum_deposit` numeric(6, 2),
    -- `max_withdrawals` int DEFAULT 5,
    PRIMARY KEY (`savings_plan_type`)
);

DROP TABLE IF EXISTS `savings_account`;
CREATE TABLE `savings_account` (
    `account_number` int(16) ZEROFILL NOT NULL,
    `next_calculation_on` date,
    `savings_plan_type` enum('Children', 'Teen', 'Adult', 'Senior') NOT NULL,
    PRIMARY KEY (`account_number`),
    FOREIGN KEY (`account_number`) REFERENCES `account`(`account_number`),
    FOREIGN KEY (`savings_plan_type`) REFERENCES `savings_plan`(`savings_plan_type`)
);

DROP TABLE IF EXISTS `checking_account`;
CREATE TABLE `checking_account` (
    `account_number` int(16) ZEROFILL NOT NULL,
    PRIMARY KEY (`account_number`),
    FOREIGN KEY (`account_number`) REFERENCES `account`(`account_number`)
);

DROP TABLE IF EXISTS `fd_plan`;
CREATE TABLE `fd_plan` (
    `fd_plan_id` int NOT NULL,
    `interest` numeric(4, 2) NOT NULL,
    `duration_in_months` int NOT NULL,
    PRIMARY KEY (`fd_plan_id`)
);

DROP TABLE IF EXISTS `fd`;
CREATE TABLE `fd` (
    `fd_no` int NOT NULL,
    `fd_plan_id` int NOT NULL,
    `savings_account_number` int(16) ZEROFILL NOT NULL,
    `branch_id` int UNSIGNED NOT NULL,
    `open_date` date NOT NULL,
    `amount` numeric(8, 2) NOT NULL,
    `fd_status` enum('Active', 'Matured', 'Withdrawn') NOT NULL,
    `maturity_date` date,
    PRIMARY KEY (`fd_no`),
    FOREIGN KEY (`fd_plan_id`) REFERENCES `fd_plan`(`fd_plan_id`),
    FOREIGN KEY (`savings_account_number`) REFERENCES `savings_account`(`account_number`),
    FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`)
);

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
    `transaction_id` int NOT NULL AUTO_INCREMENT,
    `amount` numeric(6,2) CHECK (amount > 0) ,
    `transaction_type` enum('Deposit', 'Withdrawal', 'Transfer') NOT NULL,
    `time_stamp` datetime NOT NULL,
    PRIMARY KEY (`transaction_id`)
);

DROP TABLE IF EXISTS `deposit`;
CREATE TABLE `deposit` (
    `transaction_id` int NOT NULL,
    `account_number` int(16) ZEROFILL NOT NULL,
    PRIMARY KEY (`transaction_id`),
    FOREIGN KEY (`transaction_id`) REFERENCES `transaction`(`transaction_id`),
    FOREIGN KEY (`account_number`) REFERENCES `account`(`account_number`)
);

DROP TABLE IF EXISTS `withdrawal`;
CREATE TABLE `withdrawal` (
    `transaction_id` int NOT NULL,
    `account_number` int(16) ZEROFILL NOT NULL,
    PRIMARY KEY (`transaction_id`),
    FOREIGN KEY (`transaction_id`) REFERENCES `transaction`(`transaction_id`),
    FOREIGN KEY (`account_number`) REFERENCES `account`(`account_number`) 
);

DROP TABLE IF EXISTS `transfer`;
CREATE TABLE `transfer` (
    `transaction_id` int NOT NULL,
    `sender_account_number` int(16) ZEROFILL NOT NULL,
    `receiver_account_number` int(16) ZEROFILL NOT NULL,
    PRIMARY KEY (`transaction_id`),
    FOREIGN KEY (`transaction_id`) REFERENCES `transaction`(`transaction_id`),
    FOREIGN KEY (`sender_account_number`) REFERENCES `account`(`account_number`),
    FOREIGN KEY (`receiver_account_number`) REFERENCES `account`(`account_number`) 
);

DROP TABLE IF EXISTS `loan`;
CREATE TABLE `loan` (
    `loan_id` int NOT NULL AUTO_INCREMENT,
    `customer_id` int UNSIGNED NOT NULL,
    `loan_type` enum('Business', 'Personal') NOT NULL,
    `loan_amount` numeric(8,2) CHECK (500000 > `loan_amount` > 0),
    `open_date` date,
    `final_payment_date` date,
    PRIMARY KEY (`loan_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`)
);

DROP TABLE IF EXISTS `online_loan`;
CREATE TABLE `online_loan` (
    `loan_id` int NOT NULL,
    `fd_no` int NOT NULL,
    PRIMARY KEY (`loan_id`),
    FOREIGN KEY (`fd_no`) REFERENCES `fd`(`fd_no`)
);

DROP TABLE IF EXISTS `offline_loan`;
CREATE TABLE `offline_loan` (
    `loan_id` int NOT NULL,
    `request_id` int NOT NULL,
    PRIMARY KEY (`loan_id`),
    FOREIGN KEY (`request_id`) REFERENCES `loan_request`(`request_id`)
);

DROP TABLE IF EXISTS `loan_request`;
CREATE TABLE `loan_request` (
    `request_id` int NOT NULL AUTO_INCREMENT,
    `customer_id` int UNSIGNED NOT NULL,
    `branch_id` int UNSIGNED NOT NULL,
    `is_approved` bool NOT NULL DEFAULT false,
    `loan_amount` numeric(8, 2) CHECK (500000 > `loan_amount` > 0),
    `loan_type` enum('Business', 'Personal') NOT NULL,
    PRIMARY KEY (`request_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`),
    FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`)
);

DROP TABLE IF EXISTS `loan_installment`;
CREATE TABLE `loan_installment` (
    `loan_id` int NOT NULL,
    `amount` numeric(7, 2) CHECK (500000 > `amount` > 0),
    `due_date` date NOT NULL,
    `payment_date` date,
    PRIMARY KEY (`loan_id`, `due_date`),
    FOREIGN KEY (`loan_id`) REFERENCES `loan`(`loan_id`)
);

DROP TABLE IF EXISTS `loan_arrears`;
CREATE TABLE `loan_arrears` (
    `loan_id` int NOT NULL,
    `arrear_amount` numeric(7, 2) CHECK (500000 > `arrear_amount` > 0),
    PRIMARY KEY (`loan_id`),
    FOREIGN KEY (`loan_id`) REFERENCES `loan`(`loan_id`)
);

DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
    `report_id` int NOT NULL AUTO_INCREMENT,
    `report_type` enum('Transaction Report','Loan Installment Report') NOT NULL,
    `time_stamp` datetime NOT NULL,
    `manager_id` int UNSIGNED NOT NULL,
    PRIMARY KEY (`report_id`),
    FOREIGN KEY (`manager_id`) REFERENCES `employee`(`employee_id`)
);

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
