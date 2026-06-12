USE college;

-- Show only unique ages
SELECT DISTINCT age FROM students;

-- Students age greater than 20
SELECT * FROM students
WHERE age > 20;

-- Students age less than 23
SELECT * FROM students
WHERE age < 23;

-- AND Operator
SELECT * FROM students
WHERE age > 20 AND age < 24;

-- OR Operator
SELECT * FROM students
WHERE id = 1 OR id = 4;

-- NOT Operator
SELECT * FROM students
WHERE NOT age = 20;

-- Limit records
SELECT * FROM students
LIMIT 2;