####  6. Join Ordering and Optimization Heuristics

This topic has two parts:

Join Ordering
Optimization Heuristics

Both are important because the order in which database operations are performed can greatly affect query performance.

6.1 Join Ordering
Definition

Join ordering is the process of determining the most efficient order in which multiple tables should be joined during query execution.

When a query joins several tables, there can be many possible join orders. Although these orders may produce the same final result, their execution costs can be different.

Example

Suppose we have three tables:

Employee
Department
Project

A query may require:

Employee JOIN Department JOIN Project

Possible join orders include:

(Employee JOIN Department) JOIN Project

or:

Employee JOIN (Department JOIN Project)

The DBMS optimizer estimates the cost of different orders and selects an efficient one.

Simple Practical Example

Suppose:

Employee       → 1,000,000 rows
Department     → 100 rows
Project        → 5,000 rows

If we first join two very large relations, the intermediate result may become very large.

A better strategy may be to apply filtering first and then perform the joins.

Filter Employee
      ↓
Reduced Employee
      ↓
Join Department
      ↓
Join Project

The exact best order depends on the data, indexes, predicates, and optimizer's cost estimates.

Advantages of Good Join Ordering
Reduces the size of intermediate results.
Reduces CPU and memory usage.
Can reduce disk I/O.
Improves query execution performance.
Is especially important for queries involving many tables.
Disadvantages / Challenges
The number of possible join orders increases rapidly as the number of tables increases.
Finding the globally optimal order can be computationally expensive.
Incorrect statistics can cause the optimizer to select an inefficient order.
Different data distributions may make one join order better than another.
6.2 Optimization Heuristics
Definition

Optimization heuristics are rules or strategies used by a DBMS to transform a query into a more efficient form without examining every possible execution plan.

The main purpose is to reduce processing cost and reduce the search space of the optimizer.

Important Optimization Heuristics
1. Perform Selection Early

Selection should generally be performed as early as possible.

Example:

SELECT e.name, d.department_name
FROM Employee e
JOIN Department d
ON e.department_id = d.id
WHERE e.salary > 50000;

Instead of:

Employee
   ↓
JOIN Department
   ↓
Filter salary > 50000

we can conceptually do:

Employee
   ↓
Filter salary > 50000
   ↓
JOIN Department
Benefit

Fewer Employee rows participate in the join.

2. Perform Projection Early

Remove unnecessary columns as early as possible.

For example, if only name and department_id are needed, there is no need to carry every Employee column through the entire execution process.

Benefit
Reduces data size.
Reduces memory usage.
Reduces processing overhead.
3. Perform the Most Selective Operations Early

A selective operation significantly reduces the number of rows.

For example:

1,000,000 rows
       ↓
salary > 100000
       ↓
10,000 rows

Processing the 10,000 rows in later operations is usually cheaper than processing all 1,000,000 rows.

4. Reduce Intermediate Results

The optimizer generally tries to keep intermediate results small.

Large Table
    ↓
Selection
    ↓
Smaller Result
    ↓
Join

rather than:

Large Table
    ↓
Join
    ↓
Very Large Intermediate Result
    ↓
Selection
5. Choose an Appropriate Join Order

For multiple-table queries, the optimizer attempts to perform joins in an order that reduces the amount of intermediate data.

Example:

A JOIN B JOIN C

Possible order:

(A JOIN B) JOIN C

or:

A JOIN (B JOIN C)

The optimizer uses statistics and cost estimates to determine a suitable order.

Example of Combined Heuristics

Consider:

SELECT e.name, d.department_name
FROM Employee e
JOIN Department d
ON e.department_id = d.id
WHERE e.salary > 50000;

An optimized conceptual execution could be:

             Employee
                 ↓
        Selection: salary > 50000
                 ↓
          Reduced Employee
                 ↓
              JOIN
             /    \
            /      \
           ↓        ↓
     Employee    Department
                 ↓
        Projection
                 ↓
       name, department_name

The idea is:

Filter unnecessary rows first, keep only required columns, and then perform the join.

Advantages of Optimization Heuristics
Reduces query execution cost.
Reduces the search space for the optimizer.
Reduces intermediate results.
Can improve CPU and memory utilization.
Makes optimization practical for complex queries.
Disadvantages
A heuristic does not always produce the globally optimal execution plan.
The effectiveness of a heuristic depends on the data and query.
Incorrect statistics can reduce its effectiveness.
Complex queries may still require cost-based optimization.
⭐ Exam-Ready Answer

Join ordering is the process of determining the order in which multiple tables should be joined to achieve efficient query execution. Different join orders can produce the same final result but may have different execution costs. The optimizer attempts to select an order that minimizes intermediate results and resource consumption.

Optimization heuristics are rules used to improve query execution without evaluating every possible execution plan. Common heuristics include performing selections and projections early, applying highly selective conditions first, reducing intermediate results, and choosing an appropriate join order. These techniques reduce CPU, memory, and disk I/O requirements and improve query performance.

Easy memory trick:
JOIN ORDERING
      ↓
Choose the order of joins
      ↓
Reduce intermediate results

HEURISTICS
      ↓
Filter early
Project early
Reduce data
Choose efficient join order

Company connection: In a real backend system such as Log Sentinel, queries may eventually join logs, users, incidents, and tickets. Understanding join ordering and heuristics helps you understand why the same multi-table query can have very different performance depending on how the database executes it.


#####     7. Use of Indexes in Query Plans
Definition

An index is a database structure that helps the DBMS find rows faster without scanning the entire table.

Use of indexes in query plans means that the query optimizer considers available indexes and may choose an index-based execution plan when it estimates that the index will reduce the query cost.

1. Why do we need indexes?

Suppose employee has 1,000,000 rows and we execute:

SELECT *
FROM employee
WHERE salary > 50000;

Without an index:

Full Table Scan
1,000,000 rows
       ↓
Check salary of every row
       ↓
Find matching rows

This can require a lot of I/O.

With an index on salary:

Index on salary
       ↓
Find relevant entries
       ↓
Access matching rows

The DBMS may therefore examine fewer rows.

2. Create an Index

For your current employee table, create an index on salary:

CREATE INDEX idx_employee_salary
ON employee(salary);

Check the indexes:

SHOW INDEX FROM employee;

You should see something similar to:

idx_employee_salary
3. Check the Query Plan

Now run:

EXPLAIN
SELECT name
FROM employee
WHERE salary > 50000;

Before creating the index, you had:

type = ALL
possible_keys = NULL
key = NULL

After creating the index, MySQL may show something like:

possible_keys = idx_employee_salary
key           = idx_employee_salary

The exact output depends on the table size, statistics, and optimizer's cost calculation.

Important point ⭐

Creating an index does NOT mean MySQL must use it.

The optimizer decides whether using the index is cheaper than another available plan.

4. Important EXPLAIN Fields

For indexes, focus especially on these:

Field	Meaning
possible_keys	Indexes MySQL could potentially use
key	Index actually selected by optimizer
key_len	Length of the index portion used
rows	Estimated number of rows examined
type	Access method used
Extra	Additional execution information
Easy memory trick:
possible_keys → What CAN be used?
key           → What WAS used?
rows          → How many rows are estimated?
type          → HOW is data accessed?
5. Index Scan vs Full Table Scan
Without useful index
type = ALL

Table
 ↓
Read many/all rows
 ↓
Apply condition
With useful index
Index
 ↓
Find matching entries
 ↓
Access required rows

For large tables, the second approach can significantly reduce work when the condition is selective.

6. When is an Index Useful?

Indexes are particularly useful for columns frequently used in:

WHERE
JOIN
ORDER BY
GROUP BY

For example:

SELECT *
FROM employee
WHERE salary = 75000;

An index on salary can help locate matching rows.

For your Log Sentinel project, indexes can be useful on columns such as:

log level
timestamp
source
user_id
incident_id

when those columns are frequently used for filtering or joining.

7. Advantages of Indexes
Faster data retrieval
Reduces unnecessary table scanning
Can reduce disk I/O
Can improve JOIN performance
Can improve filtering and sorting operations
8. Disadvantages of Indexes

Indexes are not free.

Require additional storage.
INSERT, UPDATE, and DELETE can become more expensive because indexes may also need to be updated.
Too many indexes can increase database maintenance cost.
An index may not help when a query returns a very large percentage of the table.
The optimizer may decide that a full scan is cheaper.
9. Practical Example with Your Database

Your current query:

SELECT e.name, d.department_name
FROM employee e
JOIN departments d
ON e.department = d.department_name
WHERE e.salary > 50000;

You can create:

CREATE INDEX idx_employee_salary
ON employee(salary);

Then:

EXPLAIN
SELECT e.name, d.department_name
FROM employee e
JOIN departments d
ON e.department = d.department_name
WHERE e.salary > 50000;

Now compare:

BEFORE INDEX
type           = ALL
possible_keys  = NULL
key            = NULL

with the new EXPLAIN output.

Because your table currently contains only 4 employee rows, MySQL may still choose a table scan. That is normal. An index becomes more meaningful as the table becomes larger or the query becomes sufficiently selective.

Exam-ready answer

Use of indexes in query plans refers to the use of database indexes by the query optimizer to efficiently locate and retrieve required rows. During query optimization, the DBMS examines available indexes and estimates whether using an index will reduce the cost of query execution. The EXPLAIN command can be used to inspect whether an index is considered and selected. Important fields include possible_keys, key, key_len, rows, and type. Indexes can improve query performance and reduce I/O, but they require additional storage and can increase the cost of insert, update, and delete operations.

One-line memory trick

Index → Find data faster → Optimizer decides whether to use it → EXPLAIN shows the decision.

###  Materialized views.  
###  Materialized Views
Definition

A materialized view is a database object that stores the result of a query physically, so that the stored result can be reused instead of executing the complete query every time.

Simple meaning:

Normal View → stores query, not result
Materialized View → stores query result

1. Why do we need Materialized Views?

Suppose we frequently run a complex query:

SELECT department, AVG(salary)
FROM employee
GROUP BY department;

If the database has millions of employee records, executing this query repeatedly can be expensive.

A materialized view can store the calculated result:

Employee table
     ↓
Complex query
     ↓
Materialized View
     ↓
Stored result

Later, applications can read the stored result much faster.

2. Normal View vs Materialized View
Feature	Normal View	Materialized View
Stores query	✅	✅
Stores result physically	❌	✅
Query executed every time	Usually yes	Usually no
Data always current	Generally yes	Can become stale
Storage required	Very little	Additional storage
Query performance	Depends on underlying query	Often faster
Refresh required	No separate refresh	Yes
Easy memory:

View = saved query
Materialized View = saved query result

3. Example

Imagine a large employee table:

SELECT department, AVG(salary) AS average_salary
FROM employee
GROUP BY department;

The result could be:

IT        67500
HR        45000
Finance   55000

A materialized view stores this result.

When the application needs the department salary summary, it can read the already-computed data instead of performing the complete aggregation again.

4. Refreshing a Materialized View

Because a materialized view stores a snapshot of data, the underlying tables can change.

For example:

Employee salary changes
        ↓
Original data changes
        ↓
Materialized View may contain old result

Therefore, the materialized view needs to be refreshed.

Common refresh approaches:

Complete Refresh

The materialized view is completely rebuilt.

Old result
   ↓
Remove/recalculate
   ↓
New result
Incremental Refresh

Only the changes are applied to the materialized view.

Small data change
      ↓
Update affected result

Incremental refresh can be more efficient for large datasets, but it is more complex.

5. Advantages
1. Faster query performance

Complex queries can be answered using precomputed results.

2. Reduces CPU and I/O

The DBMS may avoid repeatedly scanning and processing large tables.

3. Useful for reporting

Very useful for dashboards, reports, and analytics.

4. Useful for complex queries

Especially when queries involve:

Multiple JOINs
Aggregation
GROUP BY
Large datasets
6. Disadvantages
1. Additional storage

The result must be physically stored.

2. Data can become stale

If the underlying table changes, the materialized view may not immediately reflect those changes.

3. Refresh overhead

Refreshing the materialized view requires additional processing.

4. Maintenance

The database/application needs a suitable refresh strategy.

7. Materialized View in MySQL

Important practical point: MySQL does not provide native CREATE MATERIALIZED VIEW syntax like some other database systems.

For learning/practical purposes, MySQL materialized-view-like behavior can be implemented using a summary table.

For example:

CREATE TABLE department_salary_summary AS
SELECT department, AVG(salary) AS average_salary
FROM employee
GROUP BY department;

Now:

SELECT *
FROM department_salary_summary;

The result is physically stored in the table.

If employee data changes, you need to refresh/rebuild the summary table.

For example:

TRUNCATE TABLE department_salary_summary;

Then:

INSERT INTO department_salary_summary
SELECT department, AVG(salary)
FROM employee
GROUP BY department;

This is a simple way to understand the materialized-result concept in MySQL.

8. Company/Project Example

For your Log Sentinel project, imagine millions of logs:

Logs
 ↓
Complex analysis
 ↓
Daily error count by source
 ↓
Dashboard

Instead of calculating the same statistics every time the dashboard loads, you could maintain a precomputed summary such as:

Date        Source       Error_Count
2026-09-25  Server-A     1520
2026-09-25  Server-B      830

The dashboard can read the summary quickly.

This is where materialized views are useful in reporting and analytics systems.

Exam-ready answer

A materialized view is a database object that physically stores the result of a query. It improves query performance by allowing the DBMS to reuse precomputed results instead of executing complex queries repeatedly. However, the stored result may become outdated when the underlying data changes, so the materialized view must be refreshed. Materialized views are especially useful for reporting, dashboards, aggregation, and complex queries involving large datasets.

One-line memory trick

Materialized View = Precomputed + Physically Stored Query Result + Refresh Required.