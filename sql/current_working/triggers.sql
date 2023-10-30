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
