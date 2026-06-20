# Practice Questions - Primary Key, Foreign Key and Constraints

## Q1. What is the Primary Key in the following table?

Student

| Student_ID | Name | Age |
| ---------- | ---- | --- |

### Answer:

Student_ID is the Primary Key because it uniquely identifies each student record.

---

## Q2. What is the Foreign Key in the following tables?

Course

| Course_ID | Course_Name |
| --------- | ----------- |

Student

| Student_ID | Name | Course_ID |
| ---------- | ---- | --------- |

### Answer:

Course_ID in the Student table is the Foreign Key because it refers to the Primary Key of the Course table.

---

## Q3. Write any two rules of a Primary Key.

### Answer:

1. Duplicate values are not allowed.
2. NULL values are not allowed.

---

## Q4. Which constraint prevents duplicate values?

A. CHECK

B. UNIQUE

C. DEFAULT

D. NOT NULL

### Answer:

B. UNIQUE

Explanation:
The UNIQUE constraint ensures that all values in a column are different.

---

## Q5. Which constraint prevents NULL values?

A. UNIQUE

B. CHECK

C. NOT NULL

D. DEFAULT

### Answer:

C. NOT NULL

Explanation:
The NOT NULL constraint ensures that a column cannot contain NULL values.

---

## Q6. What does the following constraint do?

```sql
Age INT CHECK (Age >= 18)
```

### Answer:

This is a CHECK constraint.

It ensures that only values greater than or equal to 18 can be stored in the Age column.

---

## Q7. True or False

Foreign Key always refers to the Primary Key of another table.

### Answer:

True

Explanation:
A Foreign Key creates a relationship between two tables by referencing the Primary Key of another table.

---

## Q8. Identify the Primary Keys and Foreign Key.

Department

| Dept_ID | Dept_Name |
| ------- | --------- |

Employee

| Emp_ID | Emp_Name | Dept_ID |
| ------ | -------- | ------- |

### Answer:

Department Table:

* Primary Key = Dept_ID

Employee Table:

* Primary Key = Emp_ID
* Foreign Key = Dept_ID

Explanation:
Dept_ID in Employee refers to Dept_ID in Department.

---

## Q9. Which constraint should be used if Email values must not be duplicated?

### Answer:

UNIQUE Constraint

Example:

```sql
Email VARCHAR(100) UNIQUE
```

Explanation:
The UNIQUE constraint prevents duplicate email addresses.

---

## Q10. Identify the Foreign Key.

Company

| Company_ID | Company_Name |
| ---------- | ------------ |

Employee

| Emp_ID | Emp_Name | Company_ID |
| ------ | -------- | ---------- |

### Answer:

Company_ID in the Employee table is the Foreign Key.

Explanation:
It refers to the Primary Key (Company_ID) of the Company table and connects both tables.
