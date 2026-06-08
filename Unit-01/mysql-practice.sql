CREATE DATABASE college;

USE college;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

INSERT INTO students VALUES (1,'Abdullah',20);
INSERT INTO students VALUES (2,'Aman',24);

SELECT * FROM students;