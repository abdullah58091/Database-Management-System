# Unit 2 - Integrity Constraints

## Primary Key (PK)

### Definition

A Primary Key is an attribute that uniquely identifies each record in a table.

### Rules

* Duplicate values are not allowed.
* NULL values are not allowed.
* Each record must have a unique value.

### Example

| Student_ID | Name  | Age |
| ---------- | ----- | --- |
| 101        | Ali   | 20  |
| 102        | Ahmed | 21  |
| 103        | Khan  | 22  |

Student_ID is the Primary Key.

### SQL Example

```sql
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
```

---

## Foreign Key (FK)

### Definition

A Foreign Key is an attribute in one table that refers to the Primary Key of another table.

### Example

Student Table

| Student_ID | Name  |
| ---------- | ----- |
| 101        | Ali   |
| 102        | Ahmed |

Result Table

| Result_ID | Student_ID | Marks |
| --------- | ---------- | ----- |
| 1         | 101        | 85    |
| 2         | 102        | 90    |

Here, Student_ID in the Result table is a Foreign Key.

### SQL Example

```sql
CREATE TABLE Result (
    Result_ID INT PRIMARY KEY,
    Student_ID INT,
    Marks INT,
    FOREIGN KEY (Student_ID)
    REFERENCES Student(Student_ID)
);
```

---

# Integrity Constraints

### Definition

Integrity Constraints are rules that ensure the accuracy and consistency of data in a database.

---

## NOT NULL Constraint

### Definition

The NOT NULL constraint ensures that a column cannot have NULL values.

### Example

```sql
Name VARCHAR(50) NOT NULL
```

---

## UNIQUE Constraint

### Definition

The UNIQUE constraint ensures that all values in a column are different.

### Example

```sql
Email VARCHAR(100) UNIQUE
```

---

## PRIMARY KEY Constraint

### Definition

A PRIMARY KEY uniquely identifies each record in a table.

### Example

```sql
Student_ID INT PRIMARY KEY
```

---

## FOREIGN KEY Constraint

### Definition

A FOREIGN KEY creates a relationship between two tables.

### Example

```sql
FOREIGN KEY (Student_ID)
REFERENCES Student(Student_ID)
```

---

## CHECK Constraint

### Definition

The CHECK constraint restricts values according to a condition.

### Example

```sql
Age INT CHECK (Age >= 18)
```

Only age 18 or greater is allowed.

---

## DEFAULT Constraint

### Definition

The DEFAULT constraint provides a default value when no value is specified.

### Example

```sql
Country VARCHAR(50) DEFAULT 'India'
```

If no country is entered, 'India' will be stored automatically.

---

# Quick Revision

## Primary Key

* Unique
* Not Null
* Identifies each record

## Foreign Key

* References another table's Primary Key
* Connects tables

## Constraints

* NOT NULL
* UNIQUE
* PRIMARY KEY
* FOREIGN KEY
* CHECK
* DEFAULT
