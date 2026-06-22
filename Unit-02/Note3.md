# Unit 2 - Relational Data Model

## 1. Entity

### Definition

An entity is a real-world object about which data is stored in a database.

### Examples

* Student
* Teacher
* Employee
* Course

---

## 2. Attribute

### Definition

An attribute is a property or characteristic of an entity.

### Example

Student

* Student_ID
* Name
* Age

Here Student_ID, Name and Age are attributes.

---

## 3. Relationship

### Definition

A relationship represents an association between two or more entities.

### Example

Student ----- Enrolls ----- Course

Teacher ----- Teaches ----- Course

---

## 4. ER Diagram

### Definition

An Entity Relationship (ER) Diagram is a graphical representation of entities, attributes and relationships in a database.

### Example

Student

* Student_ID
* Name
* Age

Course

* Course_ID
* Course_Name

Student ----- Enrolls ----- Course

---

# Relational Schema Design

## Definition

A relational schema is the logical structure of a database table showing its attributes and relationships.

### Example

Student(Student_ID, Name, Age)

Course(Course_ID, Course_Name)

### Formula

Entity → Table

Attributes → Columns

Schema → TableName(Column1, Column2, Column3)

---

# Integrity Constraints

## Definition

Integrity Constraints are rules used to maintain the accuracy and consistency of data in a database.

---

# Primary Key (PK)

## Definition

A Primary Key is an attribute that uniquely identifies each record in a table.

### Rules

* Must be unique
* Cannot contain NULL values
* Duplicate values are not allowed

### Example

| Student_ID | Name  |
| ---------- | ----- |
| 101        | Ali   |
| 102        | Ahmed |

Student_ID is the Primary Key.

### SQL Example

```sql
CREATE TABLE Student(
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
```

---

# Foreign Key (FK)

## Definition

A Foreign Key is an attribute in one table that refers to the Primary Key of another table.

### Example

Student

| Student_ID | Name  |
| ---------- | ----- |
| 101        | Ali   |
| 102        | Ahmed |

Result

| Result_ID | Student_ID | Marks |
| --------- | ---------- | ----- |
| 1         | 101        | 85    |
| 2         | 102        | 90    |

Student_ID in Result table is the Foreign Key.

### SQL Example

```sql
CREATE TABLE Result(
    Result_ID INT PRIMARY KEY,
    Student_ID INT,
    Marks INT,
    FOREIGN KEY(Student_ID)
    REFERENCES Student(Student_ID)
);
```

---

# NOT NULL Constraint

## Definition

The NOT NULL constraint prevents a column from storing NULL values.

### Example

```sql
Name VARCHAR(50) NOT NULL
```

---

# UNIQUE Constraint

## Definition

The UNIQUE constraint ensures that duplicate values cannot be stored.

### Example

```sql
Email VARCHAR(100) UNIQUE
```

---

# CHECK Constraint

## Definition

The CHECK constraint restricts values according to a specified condition.

### Example

```sql
Age INT CHECK(Age >= 18)
```

Only values greater than or equal to 18 are allowed.

---

# DEFAULT Constraint

## Definition

The DEFAULT constraint assigns a default value when no value is provided.

### Example

```sql
Country VARCHAR(50) DEFAULT 'India'
```

---

# Normalization

## Definition

Normalization is the process of organizing data in a database to reduce redundancy and improve consistency.

---

# First Normal Form (1NF)

## Rule

* No repeating groups
* One value per cell
* Atomic values only

### Not in 1NF

| Roll_No | Name | Skills    |
| ------- | ---- | --------- |
| 1       | Ali  | C++, Java |

### Why?

Skills column contains multiple values in a single cell.

### In 1NF

| Roll_No | Name | Skill |
| ------- | ---- | ----- |
| 1       | Ali  | C++   |
| 1       | Ali  | Java  |

### Definition

A relation is in First Normal Form (1NF) if every attribute contains atomic values and there are no repeating groups.

---

# Second Normal Form (2NF)

## Rule

* Must be in 1NF
* Remove Partial Dependency

### Definition

A relation is in Second Normal Form (2NF) if it is in 1NF and contains no partial dependency.

### Key Point

2NF removes Partial Dependency.

---

# Third Normal Form (3NF)

## Rule

* Must be in 2NF
* Remove Transitive Dependency

### Definition

A relation is in Third Normal Form (3NF) if it is in 2NF and contains no transitive dependency.

### Key Point

3NF removes Transitive Dependency.

---

# Practice Test

## Q1

Table:

| Roll_No | Name | Skills    |
| ------- | ---- | --------- |
| 1       | Ali  | C++, Java |

### Answer

This table is not in 1NF because the Skills column contains multiple values in a single cell.

1NF requires atomic values.

---

## Q2

Which dependency is removed in 2NF?

### Answer

Partial Dependency

---

## Q3

Which dependency is removed in 3NF?

### Answer

Transitive Dependency

---

## Q4

Fill in the blanks

### Answer

1NF → Remove Repeating Groups

2NF → Remove Partial Dependency

3NF → Remove Transitive Dependency

---

# Quick Revision

## Primary Key

* Unique
* Not NULL
* Identifies records

## Foreign Key

* References another table's Primary Key
* Connects tables

## Constraints

* NOT NULL
* UNIQUE
* CHECK
* DEFAULT
* PRIMARY KEY
* FOREIGN KEY

## Golden Interview Line

1NF → Remove Repeating Groups

2NF → Remove Partial Dependency

3NF → Remove Transitive Dependency

---

# Unit 2 Status

✓ Entity

✓ Attribute

✓ Relationship

✓ ER Diagram

✓ Relational Schema Design

✓ Primary Key

✓ Foreign Key

✓ NOT NULL

✓ UNIQUE

✓ CHECK

✓ DEFAULT

✓ 1NF

✓ 2NF

✓ 3NF

Unit 2 Successfully Completed.
