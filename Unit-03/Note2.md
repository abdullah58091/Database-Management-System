# SQL TASK 2 – THEORY NOTES

# 1. SQL JOINS

## Definition

A SQL JOIN is used to combine data from two or more tables based on a related column between them. Joins help retrieve meaningful information by linking records stored in different tables.

### Example

Suppose there are two tables:

Students Table

| Student ID | Student Name |
| ---------- | ------------ |
| 1          | Ali          |
| 2          | Ahmed        |
| 3          | Saif         |

Marks Table

| Student ID | Marks |
| ---------- | ----- |
| 1          | 80    |
| 2          | 90    |
| 4          | 70    |

These tables can be connected using the Student ID column.

---

## INNER JOIN

### Definition

INNER JOIN returns only the records that have matching values in both tables.

### Example

If Student ID 1 and 2 exist in both tables, only those records will be displayed.

### Result

Ali – 80

Ahmed – 90

### Key Point

Only matching records are returned.

---

## LEFT JOIN

### Definition

LEFT JOIN returns all records from the left table and the matching records from the right table. If no match is found, NULL values are returned.

### Example

All students will be displayed even if some students do not have marks.

### Result

Ali – 80

Ahmed – 90

Saif – NULL

### Key Point

All records from the left table are always included.

---

## RIGHT JOIN

### Definition

RIGHT JOIN returns all records from the right table and the matching records from the left table.

### Example

All marks records will be displayed even if some students are not found in the Students table.

### Result

Ali – 80

Ahmed – 90

NULL – 70

### Key Point

All records from the right table are always included.

---

## FULL JOIN

### Definition

FULL JOIN returns all records from both tables. Matching records are combined, while non-matching records show NULL values.

### Example

All students and all marks records are displayed.

### Key Point

It combines the results of both LEFT JOIN and RIGHT JOIN.

### Note

MySQL does not directly support FULL JOIN.

---

# 2. SUBQUERIES

## Definition

A Subquery is a query written inside another SQL query. The inner query executes first, and its result is used by the outer query.

### Example

A company wants to find employees whose salary is greater than the average salary of all employees.

The average salary is calculated first, and then employees with higher salaries are displayed.

### Key Point

A Subquery is also known as an Inner Query or Nested Query.

---

## Single-Row Subquery

### Definition

A Single-Row Subquery returns only one value.

### Example

Finding the employee with the highest salary.

The inner query returns one value (highest salary), and the outer query finds the employee having that salary.

### Key Point

Returns exactly one value.

---

## Nested Query

### Definition

A Nested Query is a query placed inside another query.

### Example

Finding students who scored more than the average marks of the class.

The average marks are calculated first, and then students above that average are displayed.

### Key Point

The inner query always executes before the outer query.

---

# 3. AGGREGATE FUNCTIONS

## Definition

Aggregate Functions perform calculations on multiple rows of data and return a single result.

These functions are commonly used for data analysis and reporting.

---

## COUNT()

### Definition

COUNT() returns the total number of records in a table.

### Example

If a table contains 50 students, COUNT() returns 50.

### Key Point

Used to count rows.

---

## SUM()

### Definition

SUM() calculates the total of numeric values.

### Example

If student marks are 80, 90, and 70, the SUM is 240.

### Key Point

Used for addition.

---

## AVG()

### Definition

AVG() calculates the average value of a numeric column.

### Example

If marks are 80, 90, and 70, the average is 80.

### Key Point

Used to find the mean value.

---

## MAX()

### Definition

MAX() returns the largest value from a column.

### Example

Among marks 80, 90, and 70, MAX returns 90.

### Key Point

Used to find the highest value.

---

## MIN()

### Definition

MIN() returns the smallest value from a column.

### Example

Among marks 80, 90, and 70, MIN returns 70.

### Key Point

Used to find the lowest value.

---

# 4. DDL (DATA DEFINITION LANGUAGE)

## Definition

Data Definition Language (DDL) consists of SQL commands used to define, modify, and remove database structures such as tables and schemas.

DDL commands affect the structure of database objects rather than the data itself.

---

## CREATE

### Definition

The CREATE command is used to create new database objects such as tables, databases, views, and indexes.

### Example

Creating a new Students table in a database.

### Key Point

Used to create database objects.

---

## ALTER

### Definition

The ALTER command is used to modify the structure of an existing table.

### Example

Adding a new column named Address to a Students table.

### Key Point

Used to change table structure.

---

## DROP

### Definition

The DROP command permanently removes a database object along with all its data.

### Example

Deleting an entire Students table from the database.

### Key Point

Both data and structure are removed permanently.

---

## TRUNCATE

### Definition

The TRUNCATE command removes all records from a table while keeping the table structure intact.

### Example

Deleting all student records but keeping the Students table available for future use.

### Key Point

Only data is removed; the table structure remains unchanged.

---

# Difference Between DROP and TRUNCATE

DROP

• Removes both table structure and data.
• Table no longer exists after execution.
• Cannot be used unless the table is recreated.

TRUNCATE

• Removes only data.
• Table structure remains available.
• New records can be inserted immediately.

---

# Quick Revision

INNER JOIN = Returns matching records only.

LEFT JOIN = Returns all records from the left table and matching records from the right table.

RIGHT JOIN = Returns all records from the right table and matching records from the left table.

FULL JOIN = Returns all records from both tables.

Subquery = A query inside another query.

COUNT() = Counts records.

SUM() = Calculates total.

AVG() = Calculates average.

MAX() = Finds highest value.

MIN() = Finds lowest value.

CREATE = Creates database objects.

ALTER = Modifies database objects.

DROP = Deletes structure and data.

TRUNCATE = Deletes data only.
