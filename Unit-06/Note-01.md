# Advanced Database Management Systems (ABDMS)

## Day 01 — Query Processing and Optimization

### Topics Covered

Today, I started studying Advanced Database Management Systems (ABDMS).

#### 1. Query Processing

* What is Query Processing?
* Steps involved in query processing
* Query execution pipeline
* Query parsing and validation
* Query optimization
* Query execution

#### 2. Query Execution Pipeline

The basic query processing flow is:

SQL Query
→ Parsing
→ Query Tree
→ Query Optimization
→ Execution Plan
→ Query Execution
→ Result

#### 3. Query Tree

* What is a Query Tree?
* Representation of SQL queries using relational algebra operations
* Role of Query Trees in query optimization

#### 4. Relational Algebra Expression Transformation

* Why query transformations are required
* Equivalent relational algebra expressions
* Transformation rules
* Reducing unnecessary operations

#### 5. Query Optimization

* What is Query Optimization?
* Why query optimization is required
* Query execution cost
* Choosing an efficient execution plan

### Key Learning

A database can execute the same SQL query in different ways. Query optimization helps the database choose an efficient execution plan that reduces execution cost and improves performance.

### Study Goal

Understand how a database converts an SQL query into an optimized execution plan and executes it efficiently.

### Next Topic

Cost-Based Query Optimization and Optimization Heuristics.


##  ABDMS
├── Day-01 Query Processing
├── Day-02 Query Optimization
├── Day-03 Distributed Databases
├── Day-04 CAP & Parallel Databases
├── Day-05 NoSQL Fundamentals
├── Day-06 MongoDB
├── Day-07 Transactions & Concurrency
├── Day-08 Recovery
├── Day-09 ARIES
├── Day-10 Big Data
├── Day-11 Cloud Databases
└── Day-12 Revision


 
 1. Query Execution Pipeline
Definition

Query processing is the process of converting a high-level SQL query into an efficient execution plan and executing that plan to produce the required result.

When a user submits an SQL query, the DBMS does not directly execute the SQL statement. It passes through several stages.

Query Processing Pipeline
SQL Query
    ↓
Parsing
    ↓
Semantic Analysis
    ↓
Query Transformation
    ↓
Query Optimization
    ↓
Execution Plan
    ↓
Query Execution
    ↓
Result
1. Parsing

The DBMS first analyzes the syntax and structure of the SQL query.

Example:

SELECT name
FROM Student
WHERE age > 20;

The parser identifies:

SELECT
name
FROM
Student
WHERE
age > 20

If the SQL syntax is incorrect, the query is rejected.

2. Semantic Analysis

The DBMS checks whether the query is logically valid.

It checks:

Whether the table exists
Whether the columns exist
Whether data types are compatible
Whether the user has the required permissions

For example:

SELECT salary
FROM Student;

If the salary column does not exist in the Student table, the query will fail.

3. Query Transformation

The DBMS converts or rewrites the query into an equivalent form that may be more efficient to execute.

For example:

SELECT name
FROM Student
WHERE age > 20;

can be represented using relational algebra as:

π name
   |
σ age > 20
   |
 Student

Where:

σ = Selection
π = Projection

Query transformation is important because an equivalent query can sometimes be executed more efficiently.

4. Query Optimization

The DBMS may have several possible ways to execute the same query.

For example:

Plan A → Full Table Scan
Plan B → Index Scan
Plan C → Different Join Order

The query optimizer evaluates these possible execution plans and selects an efficient plan based on estimated cost.

The cost may consider factors such as:

Disk I/O
CPU usage
Memory usage
Number of rows
Available indexes
Join operations
5. Execution Plan

An execution plan describes how the DBMS intends to execute a query.

For example:

Index Scan
     ↓
Filter rows
     ↓
Retrieve required columns
     ↓
Return result

In MySQL, an execution plan can be examined using:

EXPLAIN
SELECT name
FROM Student
WHERE age > 20;

EXPLAIN is particularly important when studying query optimization.

6. Query Execution

After selecting an execution plan, the DBMS executes the operations specified by that plan.

The required data is retrieved from storage, processed, and returned to the user.

2. Evaluation Strategies

An evaluation strategy is the method used by the DBMS to execute a particular relational operation.

Common strategies include:

A. Table Scan

The DBMS examines rows in a table to find the required records.

Table
 ↓
Read rows
 ↓
Check condition
 ↓
Return matching rows

This can be expensive when the table contains a large number of records.

B. Index Scan

If a suitable index exists, the DBMS may use the index to locate required records more efficiently.

Example:

CREATE INDEX idx_student_age
ON Student(age);

Then:

SELECT name
FROM Student
WHERE age > 20;

The optimizer may choose an index-based access method.

Important: The existence of an index does not guarantee that the optimizer will use it.

3. Query Tree
Definition

A query tree is a tree structure that represents the relational algebra operations required to execute a query.

The leaf nodes represent relations/tables, while the internal nodes represent relational operations.

Example:

SELECT name
FROM Student
WHERE age > 20;

Query tree:

        π name
           |
       σ age > 20
           |
        Student

Here:

Student → relation
σ age > 20 → selection
π name → projection
4. Relational Algebra Expression Transformation

A DBMS can transform a relational algebra expression into an equivalent expression.

The goal is to obtain an expression that produces the same result but can be executed more efficiently.

Example

Suppose:

π name (σ age > 20 (Student))

The DBMS may apply relational algebra transformation rules to improve execution.

One important rule is Selection Pushdown.

Instead of processing all columns/rows first, the selection can be performed as early as possible.

Student
   ↓
σ age > 20
   ↓
π name

This can reduce the amount of data processed by later operations.

5. Cost-Based Query Optimization
Definition

Cost-based query optimization is the process of selecting an efficient execution plan by estimating the cost of different possible plans.

Suppose a query has three possible plans:

Plan A → Cost = 100
Plan B → Cost = 40
Plan C → Cost = 70

The optimizer considers the estimated costs and selects an appropriate plan.

Factors affecting cost
Disk I/O
CPU processing
Memory usage
Number of rows
Selectivity of conditions
Index availability
Join operations
Join order
Important point

The optimizer generally works with estimated costs, not guaranteed execution times.

6. Join Ordering

When multiple tables are joined, the order in which the joins are performed can significantly affect query performance.

Example:

A JOIN B JOIN C

Possible execution orders include:

(A JOIN B) JOIN C

or

A JOIN (B JOIN C)

Both may produce the same logical result, but their execution costs can be different.

Therefore, the optimizer considers different join orders.

7. Optimization Heuristics
Definition

Optimization heuristics are rules used to reduce the search space and improve query execution efficiency.

Common heuristics include:

1. Perform selections early
Selection
   ↓
Join

instead of joining large tables first.

2. Perform projections early

Remove unnecessary columns as early as possible.

3. Reduce intermediate results

Try to keep intermediate relations small.

4. Choose efficient join methods

Depending on the data and indexes, the DBMS may consider different join algorithms.

8. Use of Indexes in Query Plans
Definition

An index is a data structure that helps the DBMS locate rows more efficiently without scanning the entire table.

Example:

CREATE INDEX idx_student_age
ON Student(age);

Query:

SELECT name
FROM Student
WHERE age = 21;

The optimizer can consider using:

Index
  ↓
Locate matching rows
  ↓
Retrieve data

Instead of:

Scan entire table
  ↓
Check every row
Important

Indexes can improve read performance, but they also require additional storage and can add overhead to operations such as INSERT, UPDATE, and DELETE.

9. Materialized Views
Definition

A materialized view is a stored result of a query that can be reused to reduce the cost of repeatedly executing the same complex query.

A normal view generally stores the query definition, whereas a materialized view stores the query result.

Conceptually:

Complex Query
     ↓
Materialized View
     ↓
Stored Result
     ↓
Faster access to repeated queries
Example

Suppose a company frequently calculates:

Total sales for each department

Instead of repeatedly executing a complex aggregation query, a materialized view can store the computed result.

The stored result must be refreshed when the underlying data changes, depending on the materialized-view strategy.