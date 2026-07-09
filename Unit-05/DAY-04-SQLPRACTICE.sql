Enter password: ************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.46 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| college            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.04 sec)

mysql> USE COLLEGE
Database changed
mysql> SHOW TABLES;
+-------------------+
| Tables_in_college |
+-------------------+
| marks             |
| students          |
| users             |
+-------------------+
3 rows in set (0.04 sec)

mysql> SHOW USER;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'USER' at line 1
mysql> SHOW users;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'users' at line 1
mysql> SHOW STUDENTS;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'STUDENTS' at line 1
mysql> SELECT * FROM users;
+----+---------------+
| id | email         |
+----+---------------+
|  2 | ali@gmail.com |
+----+---------------+
1 row in set (0.01 sec)

mysql> SELECT * FROM STUDENTS ;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  2 | Iram     |   18 |
|  5 | Sara     |   19 |
|  1 | Abdullah |   21 |
|  4 | Ali      |   21 |
|  6 | Zoya     |   22 |
| 11 | Sadik    |   23 |
|  3 | Arsh     |   25 |
|  9 | Jhon     |   33 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
| 10 | Ajaye    |   56 |
+----+----------+------+
11 rows in set (0.01 sec)

mysql>


## 📚 Topic 1: EXPLAIN


mysql> EXPLAIN
    -> SELECT *
    -> FROM students;
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | index | NULL          | idx_age_name | 208     | NULL |    9 |   100.00 | Using index |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE id = 5;
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age = 21;
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key          | key_len | ref   | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age_name  | idx_age_name | 5       | const |    2 |   100.00 | Using index |
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
1 row in set, 1 warning (0.03 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age > 20;
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
| id | select_type | table    | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra                    |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
|  1 | SIMPLE      | students | NULL       | index | idx_age_name  | idx_age_name | 208     | NULL |    9 |   100.00 | Using where; Using index |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> ORDER BY age;
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | index | NULL          | idx_age_name | 208     | NULL |    9 |   100.00 | Using index |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql>

## 📚 Query 1
EXPLAIN
SELECT *
FROM students;

Output

type = index
key = idx_age_name
rows = 9
Extra = Using index
Analysis
✅ type = index

index means MySQL scans the entire index instead of scanning the entire table.


📚 Query 2
WHERE id = 5;

Output

type = const
key = PRIMARY
rows = 1
Analysis
✅ type = const

Ye best access type hai.



📚 Query 3
WHERE age = 21;

Output

type = ref
key = idx_age_name
rows = 2
Extra = Using index
Analysis
✅ type = ref

Non-Unique Index use hua.


📚 Query 4
WHERE age > 20;

Output

type = index
rows = 9
Extra = Using where; Using index
Analysis
⚠️ type = index


📚 Query 5
ORDER BY age;

Output

type = index
key = idx_age_name
Extra = Using index
Analysis


⭐ Things to Remember (English)
EXPLAIN shows the execution plan of a query.
const is the fastest access type.
ref is used for non-unique index lookups.
index means MySQL scans the entire index instead of the table.
ALL means a full table scan.
possible_keys shows available indexes.
key shows the index actually used.
rows is the estimated number of rows to examine.
Using index means the query is satisfied using only the index (Covering Index).
Using where means MySQL applies a WHERE filter after reading rows.

## Topic 2: Execution Plan


9. Practical



Step 1
EXPLAIN
SELECT *
FROM students
WHERE id = 5;

Observe:

type
key
rows

Step 2
EXPLAIN
SELECT *
FROM students
WHERE age = 21;

Observe:

type
key


Step 3
EXPLAIN
SELECT *
FROM students
ORDER BY age;

Observe:

Extra


Step 4
EXPLAIN
SELECT *
FROM students
WHERE age > 20;

##  example practice
mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE id = 5;
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age = 21;
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key          | key_len | ref   | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age_name  | idx_age_name | 5       | const |    2 |   100.00 | Using index |
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> ORDER BY age;
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | index | NULL          | idx_age_name | 208     | NULL |    9 |   100.00 | Using index |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age > 20;
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
| id | select_type | table    | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra                    |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
|  1 | SIMPLE      | students | NULL       | index | idx_age_name  | idx_age_name | 208     | NULL |    9 |   100.00 | Using where; Using index |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+--------------------------+
1 row in set, 1 warning (0.00 sec)

mysql>

## Output

type = const
key = PRIMARY
rows = 1
Execution Plan
SQL Query
      ↓
    Parser
      ↓
Optimizer
      ↓
PRIMARY Index
      ↓
Read 1 Row
      ↓
Return Result


Analysis
PRIMARY index use hua.
const access type hai (Fastest).
Sirf 1 row read hui.

✅ Best Execution Plan


Output

type = ref
key = idx_age_name
rows = 2
Extra = Using index
Execution Plan
SQL Query
      ↓
Parser
      ↓
Optimizer
      ↓
Composite Index (idx_age_name)
      ↓
Read 2 Rows
      ↓
Return Result
Analysis
Optimizer ne idx_age_name choose kiya.
ref access type hai (Non-Unique Index Lookup).
Sirf 2 rows read hui.
Using index → Query index se satisfy ho gayi.

✅ Very Good Execution Plan


Output

type = index
key = idx_age_name
Extra = Using index
Execution Plan
SQL Query
      ↓
Parser
      ↓
Optimizer
      ↓
Scan idx_age_name
      ↓
Return Sorted Rows
Analysis
ORDER BY age ke liye alag sorting nahi hui.
Composite Index already age ke order me hai.
Using filesort nahi aaya.

✅ Index due to sorting fasting 



Output

type = index
rows = 9
Extra = Using where; Using index
Execution Plan
SQL Query
      ↓
Parser
      ↓
Optimizer
      ↓
Scan idx_age_name
      ↓
Apply WHERE (age > 20)
      ↓
Return Matching Rows
Analysis
Optimizer ne poora index scan karna choose kiya.
Using where → Condition apply hui.
Using index → Index se hi data mil gaya.
Chhoti table hone ki wajah se ye plan choose hua.

📚 Things to Remember (English)
The Execution Plan is created by the Query Optimizer.
const is the fastest access type.
ref indicates a non-unique index lookup.
index means MySQL scans the entire index.
Using index indicates a Covering Index.
Using where means rows are filtered after being read.
A good Execution Plan minimizes the number of rows scanned.
The Query Optimizer always tries to choose the lowest-cost execution plan.




## 📚 Topic 3: Slow Queries
9. Practical

Ab hum kuch queries ka performance observe karenge.

Step 1
EXPLAIN
SELECT *
FROM students
WHERE id = 5;

Observe:

type
rows


Step 2
EXPLAIN
SELECT *
FROM students
WHERE age = 21;

Observe:

key
rows


Step 3
EXPLAIN
SELECT *
FROM students
WHERE name = 'Ali';

Observe:

key
type


Step 4

EXPLAIN
SELECT *
FROM students
ORDER BY name;

Observe:





## 

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE id = 5;
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age = 21;
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key          | key_len | ref   | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age_name  | idx_age_name | 5       | const |    2 |   100.00 | Using index |
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE name = 'Ali';
+----+-------------+----------+------------+------+-----------------------+----------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type | possible_keys         | key      | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+------+-----------------------+----------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_name,idx_age_name | idx_name | 203     | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+------+-----------------------+----------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.03 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> ORDER BY name;
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-----------------------------+
| id | select_type | table    | partitions | type  | possible_keys | key          | key_len | ref  | rows | filtered | Extra                       |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-----------------------------+
|  1 | SIMPLE      | students | NULL       | index | NULL          | idx_age_name | 208     | NULL |    9 |   100.00 | Using index; Using filesort |
+----+-------------+----------+------------+-------+---------------+--------------+---------+------+------+----------+-----------------------------+
1 row in set, 1 warning (0.00 sec)

mysql>

Output

type = const
key = PRIMARY
rows = 1
Analysis

✅ Primary Key use hui.

✅ Sirf 1 row read hui.

const sabse fast access type hai.

Performance: ⭐⭐⭐⭐⭐ (Excellent)


Output

type = ref
key = idx_age_name
rows = 2
Extra = Using index
Analysis

age par Composite Index available hai.

MySQL ne wahi use kiya.

Sirf 2 rows scan hui.

Using index ka matlab query efficiently execute hui.

Performance: ⭐⭐⭐⭐☆ (Very Good)


Output

type = ref
key = idx_name
rows = 1
Analysis

MySQL ne idx_name choose kiya.

Kyun?

Kyuki name ke liye dedicated index available hai.

Composite Index (age, name) bhi available tha.

Lekin Optimizer ne cheaper index choose kiya.

Ye Cost-Based Optimizer ka example hai.

Performance: ⭐⭐⭐⭐☆ (Very Good)


Output

type = index

key = idx_age_name

Extra = Using index; Using filesort
Analysis
⭐ Sabse Important Output
Using filesort
Professional Definition (English)

Using filesort means MySQL performs an additional sorting operation because the required order cannot be obtained directly from an index.


🎯 Things to Remember (English)
const is the fastest access type.
ref is used for non-unique index lookups.
Primary Key lookups are very efficient.
MySQL chooses the lowest-cost index using the Cost-Based Optimizer.
Using filesort means MySQL performs an extra sorting operation.
Using filesort does not always mean disk I/O it refers to MySQL sorting algorithm.
A Composite Index follows the Leftmost Prefix Rule.
ORDER BY name cannot fully use an (age, name) index because name is not the leftmost column.



## 8. Practical

Run these commands one by one.

Step 1
SHOW PROCESSLIST;


Step 2
SHOW STATUS LIKE 'Threads_connected';


Step 3
SHOW STATUS LIKE 'Questions';

Step 4
SHOW STATUS LIKE 'Uptime';





mysql> SHOW STATUS LIKE 'Threads_connected';
+-------------------+-------+
| Variable_name     | Value |
+-------------------+-------+
| Threads_connected | 1     |
+-------------------+-------+
1 row in set (0.09 sec)

mysql>
mysql> SHOW STATUS LIKE 'Questions';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| Questions     | 27    |
+---------------+-------+
1 row in set (0.00 sec)

mysql>
mysql> SHOW STATUS LIKE 'Uptime';
+---------------+--------+
| Variable_name | Value  |
+---------------+--------+
| Uptime        | 336417 |
+---------------+--------+
1 row in set (0.04 sec)

mysql>



Output

Threads_connected = 1
Analysis
Professional Definition (English)

Threads_connected shows the number of client connections currently connected to the MySQL server.


Output

Questions = 27
Analysis
Professional Definition (English)

Questions shows the total number of SQL statements executed since the MySQL server started.


Output

Uptime = 336417
Analysis
Professional Definition (English)

Uptime indicates how long the MySQL server has been running since it was last started.

🎯 Things to Remember (English)
Threads_connected shows the current number of active client connections.
Questions shows the total SQL statements executed since the server started.
Uptime shows how long the MySQL server has been running.
These metrics help monitor database health and activity.
Performance monitoring helps detect bottlenecks before they affect users.