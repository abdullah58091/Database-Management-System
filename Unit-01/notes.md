# DBMS Unit-1 Notes

## Introduction to Database

### Database

A database is an organized collection of related data that can be easily accessed, managed, and updated.

### Example

* Student Records
* Employee Records
* Bank Accounts
* Product Information

---

## DBMS

### Definition

DBMS (Database Management System) is software used to create, manage, store, retrieve, and manipulate data in a database.

### Examples

* MySQL
* Oracle
* PostgreSQL
* SQL Server

### Advantages of DBMS

* Reduces data redundancy
* Improves data security
* Easy data retrieval
* Better data consistency
* Data sharing among multiple users

---

## Evolution of Database Systems

### Definition

Database systems evolved from traditional file systems to DBMS to provide efficient, secure, and organized data management.

### Problems with File Systems

* Data duplication
* Data inconsistency
* Poor security
* Difficult data retrieval

### Solution

DBMS was introduced to overcome these problems.

---

## Database Models

### Relational Model

#### Definition

A relational model stores data in tables consisting of rows and columns.

#### Example

Students Table

| ID | Name     |
| -- | -------- |
| 1  | Abdullah |
| 2  | Aman     |

#### Examples

* MySQL
* PostgreSQL
* Oracle

---

### Hierarchical Model

#### Definition

A hierarchical model stores data in a tree-like parent-child structure.

#### Example

College
│
├── CSE
│   ├── Abdullah
│   └── Aman
│
└── IT
└── Rahul

---

### Network Model

#### Definition

A network model allows multiple parent-child relationships between records.

#### Example

Student
/    
Course Project

---

## Importance of DBMS

### Definition

DBMS helps store, manage, secure, and retrieve large amounts of data efficiently.

### Real-Life Applications

* Instagram
* Amazon
* Netflix
* Banking Systems
* Hospital Management Systems

---

# SQL Commands Practiced

## SHOW DATABASES

### Syntax

SHOW DATABASES;

### Definition

Displays all databases available in MySQL.

---

## USE DATABASE

### Syntax

USE college;

### Definition

Selects a database for performing operations.

---

## SHOW TABLES

### Syntax

SHOW TABLES;

### Definition

Displays all tables present in the selected database.

---

## DESC TABLE

### Syntax

DESC students;

### Definition

Shows the structure of a table including columns, data types, keys, and constraints.

---

## INSERT

### Syntax

INSERT INTO students VALUES (1,'Abdullah',20);

### Definition

Inserts a new record into a table.

---

## SELECT

### Syntax

SELECT * FROM students;

### Definition

Retrieves data from a table.

---

## UPDATE

### Syntax

UPDATE students
SET age = 24
WHERE id = 2;

### Definition

Modifies existing records in a table.

---

## DELETE

### Syntax

DELETE FROM students
WHERE id = 3;

### Definition

Deletes records from a table.

---

## WHERE

### Syntax

SELECT * FROM students
WHERE age > 20;

### Definition

Filters records based on a condition.

---

## ORDER BY

### Syntax

SELECT * FROM students
ORDER BY age DESC;

### Definition

Sorts records in ascending or descending order.

---

## DISTINCT

### Syntax

SELECT DISTINCT age FROM students;

### Definition

Displays only unique values from a column.

---

## AND

### Syntax

SELECT * FROM students
WHERE age > 20 AND age < 24;

### Definition

Returns records when all conditions are true.

---

## OR

### Syntax

SELECT * FROM students
WHERE id = 1 OR id = 4;

### Definition

Returns records when at least one condition is true.

---

## NOT

### Syntax

SELECT * FROM students
WHERE NOT age = 20;

### Definition

Excludes records matching a condition.

---

## LIMIT

### Syntax

SELECT * FROM students
LIMIT 2;

### Definition

Restricts the number of rows returned.

---

# Tools Used

* MySQL Server
* MySQL Command Line Client
* Visual Studio Code (VS Code)
* Git
* GitHub

---

# Unit-1 Status

Theory Completed ✅

Practical Completed ✅

GitHub Documentation Completed ✅
