START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

COMMIT;

UPDATE Student
SET Marks = 90
WHERE id = 1;


START TRANSACTION;

UPDATE Student
SET Marks = 90
WHERE id = 1;

INSERT INTO Result
VALUES(1,'Pass');

COMMIT;