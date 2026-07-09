## 📚 Topic 1: EXPLAIN
1. Professional Definition (English)

EXPLAIN is a MySQL statement that shows how the database optimizer plans to execute a query.
 It displays the execution plan, including table access methods, indexes used, estimated rows, and other optimization details.


## 7. Interview Questions
Q1. What is EXPLAIN?

Answer:

EXPLAIN is a MySQL statement used to display the execution plan of a query before it is executed.

Q2. Does EXPLAIN execute the query?

Answer:

No.

It only shows how MySQL plans to execute the query.

Q3. Which EXPLAIN column is most important?

Answer:

type is considered the most important because it shows how MySQL accesses the data.

Q4. Why do Software Engineers use EXPLAIN?

Answer:

To analyze query performance, identify slow queries, verify index usage, and optimize SQL statements.


## 8. Summary
EXPLAIN is a powerful tool in MySQL that helps developers and database administrators understand how queries are executed.
 By providing insights into the execution plan, it allows for performance tuning and optimization of SQL queries, ensuring efficient data retrieval and resource usage.

 ## 9. References
1. MySQL Documentation: EXPLAIN Statement - https://dev.mysql.com/doc/refman/8.0/en/explain.html


## 📚 Topic 2: Execution Plan
1. Professional Definition (English)

An Execution Plan is the sequence of operations that the MySQL Query Optimizer chooses to execute an SQL query efficiently. 
It describes how tables are accessed, which indexes are used, and the order in which operations are performed.

## 7. Interview Questions


Q1. What is an Execution Plan?

Answer:

An Execution Plan is the strategy chosen by the MySQL Query Optimizer to execute an SQL query efficiently.

Q2. Who creates the Execution Plan?

Answer:

The MySQL Query Optimizer creates the Execution Plan.

Q3. Why is an Execution Plan important?

Answer:

It helps MySQL choose the most efficient way to execute a query, reducing execution time and improving performance.

Q4. How can we view an Execution Plan?

Answer:

Using the EXPLAIN statement.




## 📚 Topic 3: Slow Queries
1. Professional Definition (English)

A Slow Query is an SQL query that takes longer than an acceptable amount of time to execute.
Slow queries reduce database performance and increase application response time.

7. How to Optimize Slow Queries

✅ Create Indexes

✅ Use WHERE clause properly

✅ Avoid unnecessary SELECT *

✅ Retrieve only required columns

✅ Use Composite Indexes when needed

✅ Analyze queries with EXPLAIN


## 7. Interview Questions

Q1. What is a Slow Query?

Answer:

A Slow Query is an SQL query that takes longer than the acceptable execution time, reducing database performance.

Q2. What are common causes of Slow Queries?

Answer:

Missing indexes
Full Table Scans
Large datasets
Poor WHERE conditions
Unnecessary sorting
Retrieving unnecessary columns
Q3. Which tool is used to analyze Slow Queries?

Answer:

EXPLAIN
Slow Query Log
Q4. How can Slow Queries be optimized?

Answer:

By creating indexes, rewriting queries, reducing scanned rows, and analyzing execution plans using EXPLAIN.


## 📚 Topic 4: Performance Monitoring Basics
1. Professional Definition (English)

Database Performance Monitoring is the process of continuously observing and analyzing database activities, resource usage, 
and query performance to ensure the database operates efficiently.

## Queries

↓

Execution Time

↓

Slow Queries

↓

Optimization




## 7. Interview Questions
Q1. What is Database Performance Monitoring?

Answer:

Database Performance Monitoring is the process of tracking database performance, resource usage, and query execution to identify and resolve performance issues.

Q2. Why is Performance Monitoring important?

Answer:

It helps identify slow queries, resource bottlenecks, connection issues, and overall database health, ensuring optimal performance.

Q3. Which MySQL command shows currently running queries?

Answer:

SHOW PROCESSLIST;
Q4. Which command displays server statistics?

Answer:

SHOW STATUS;
