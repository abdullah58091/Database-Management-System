# Day 1 - SQL Programming (Task 1)

## Topics Covered

### 1. Introduction to SQL

#### What is SQL?

SQL (Structured Query Language) is a language used to manage and manipulate data stored in databases.

#### Uses of SQL

* Retrieve data from a database
* Insert new data
* Update existing data
* Delete records
* Manage database information

---

## Basic Database Concepts

### Database

A database is an organized collection of related data.

Example:
CollegeDB

### Table

A table stores data in rows and columns.

Example:

| id | name | age |
| -- | ---- | --- |
| 1  | Ali  | 20  |
| 2  | Saif | 22  |

### Row (Record)

A row represents a single record in a table.

Example:
| 1 | Ali | 20 |

### Column (Field)

A column represents a category of data.

Examples:

* id
* name
* age

---

# 2. Basic SQL Commands

## SELECT Command

Used to retrieve data from a table.

### Display All Records

```sql
SELECT * FROM students;
```

### Display Specific Column

```sql
SELECT name FROM students;
```

### Using WHERE Clause

```sql
SELECT * FROM students
WHERE age > 20;
```

Purpose:

* View all data
* View selected columns
* Apply conditions while retrieving data

---

## INSERT Command

Used to add new records into a table.

Example:

```sql
INSERT INTO students
VALUES (4,'Abdullah',19);
```

Alternative Syntax:

```sql
INSERT INTO students(id,name,age)
VALUES (4,'Abdullah',19);
```

Purpose:

* Add new records to a table

---

## UPDATE Command

Used to modify existing records.

Example:

```sql
UPDATE students
SET age = 25
WHERE id = 2;
```

Purpose:

* Change existing data
* Modify values using conditions

Important:
Always use WHERE clause to avoid updating all records.

---

## DELETE Command

Used to remove records from a table.

Example:

```sql
DELETE FROM students
WHERE id = 3;
```

Purpose:

* Delete specific records from a table

Important:
Without WHERE clause all records may be deleted.

---

# 3. Data Manipulation Language (DML)

## Definition

DML (Data Manipulation Language) is used to manipulate data stored in a database.

## DML Commands

### INSERT

Adds new records.

```sql
INSERT INTO students
VALUES (4,'Abdullah',19);
```

### UPDATE

Modifies existing records.

```sql
UPDATE students
SET age = 25
WHERE id = 2;
```

### DELETE

Removes records.

```sql
DELETE FROM students
WHERE id = 3;
```

---

# Practical Concepts Learned

* SQL Fundamentals
* Database, Table, Row, Column
* SELECT Statement
* WHERE Clause
* INSERT Statement
* UPDATE Statement
* DELETE Statement
* DML Commands

---

# Learning Outcome

After completing Task 1, I can:

✓ Understand SQL basics

✓ Identify Database, Table, Row and Column

✓ Retrieve data using SELECT

✓ Add records using INSERT

✓ Modify records using UPDATE

✓ Delete records using DELETE

✓ Understand DML and its commands

Task Status: Completed ✅
