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
