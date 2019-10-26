
CREATE schema Bank;
USE Bank;

CREATE TABLE account_balance
(
account_id INT,
balance NUMERIC(10,2)
);

INSERT INTO account_balance VALUES (0000001,1000.00);
INSERT INTO account_balance VALUES (0000002,1000.00);

CREATE TABLE transaction_log
(
user_id VARCHAR(255), 
description VARCHAR(255)
);

SELECT * FROM account_balance;
SELECT * FROM transaction_log;


CREATE PROCEDURE tfer_funds
(from_account INT, to_account INT,tfer_amount NUMERIC(10,2))
SQL SECURITY INVOKER
BEGIN
START TRANSACTION;
UPDATE account_balance
SET balance=balance-tfer_amount
WHERE account_id=from_account;
UPDATE account_balance
SET balance=balance+tfer_amount
WHERE account_id=to_account;
INSERT into transaction_log
(user_id, description)
values(user( ), concat('Transfer of ',tfer_amount,' from ',
from_account,' to ',to_account));
COMMIT;
END~

CALL tfer_funds(0000001,0000002,500.00);


SELECT * FROM account_balance;
SELECT * FROM transaction_log;

