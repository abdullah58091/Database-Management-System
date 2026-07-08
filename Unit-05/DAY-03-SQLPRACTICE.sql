SHOW INDEX FROM students;

Ye batayegi ki id pe Primary Key pehle se lagi hui hai ya nahi.

Agar output me ye line dikhe:

PRIMARY KEY (`id`)

EXPLAIN
SELECT *
FROM students
WHERE id = 3;


mysql> SHOW CREATE TABLE students;
+----------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table    | Create Table                                                                                                                                                                                                                 |
+----------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| students | CREATE TABLE `students` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_age` (`age`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+----------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.04 sec)

mysql> SHOW INDEX FROM students;
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| students |          0 | PRIMARY  |            1 | id          | A         |           9 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| students |          1 | idx_age  |            1 | age         | A         |           9 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.06 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE id = 3;
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql>



1. type = const ⭐⭐⭐⭐⭐
Professional Definition (English)

const is the fastest access type in MySQL. It is used when the query searches for a single row using a Primary Key or a Unique Index.

2. possible_keys = PRIMARY
Professional Definition

This column shows all indexes that MySQL could potentially use to execute the query.



3. key = PRIMARY ⭐⭐⭐⭐⭐
Professional Definition

This column shows the actual index chosen by the optimizer.



4. key_len = 4
Professional Definition

It shows how many bytes of the index MySQL is using.


5. ref = const
Professional Definition

This column shows the value or column that MySQL uses to compare against the index.


6. rows = 1 ⭐⭐⭐⭐⭐
Professional Definition

Estimated number of rows MySQL expects to read.



7. Extra = NULL
Professional Definition

Shows additional information about query execution.



CREATE TABLE students (
    id INT,
    name VARCHAR(50),
    age INT,
    PRIMARY KEY(id)
);



## 📚 Topic 3: Secondary Index EXAMPLE 

mysql> SHOW INDEX FROM students;
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| students |          0 | PRIMARY  |            1 | id          | A         |           9 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| students |          1 | idx_age  |            1 | age         | A         |           9 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.04 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age = 21;
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age       | idx_age | 5       | const |    2 |   100.00 | NULL  |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.04 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE name = 'Ali';
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |    11.11 | Using where |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> CREATE INDEX idx_name
    -> ON students(name);
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE name = 'Ali';
+----+-------------+----------+------------+------+---------------+----------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+------+---------------+----------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_name      | idx_name | 203     | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+------+---------------+----------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql>


1. type = ALL ❌
Professional Definition (English)

ALL indicates a Full Table Scan, where MySQL reads every row of the table to find matching records.


2. possible_keys = NULL



3. key = NULL



4. rows = 9



5. Extra = Using where


Command:

CREATE INDEX idx_name
ON students(name);

Ab dobara:

EXPLAIN
SELECT *
FROM students
WHERE name='Ali';

Output:

type          = ref
possible_keys = idx_name
key           = idx_name
rows          = 1
Extra         = NULL
1. type = ref ✅


2. possible_keys = idx_name


3. key = idx_name ⭐⭐⭐⭐⭐



4. rows = 1



5. Extra = NULL


| Without Index          | With Index                 |
| ---------------------- | -------------------------- |
| `type = ALL`           | `type = ref`               |
| `possible_keys = NULL` | `possible_keys = idx_name` |
| `key = NULL`           | `key = idx_name`           |
| `rows = 9`             | `rows = 1`                 |
| Full Table Scan        | Index Lookup               |
| Slow                   | Fast                       |



## 📚 Topic 4: Composite Index

Ab ye commands isi order me chalao:

DROP INDEX idx_age
ON students;
CREATE INDEX idx_age_name
ON students(age, name);
SHOW INDEX
FROM students;
EXPLAIN
SELECT *
FROM students
WHERE age = 21;
EXPLAIN
SELECT *
FROM students
WHERE age = 21
AND name = 'Ali';
EXPLAIN
SELECT *
FROM students
WHERE name = 'Ali';




mysql> DROP INDEX idx_age
    -> ON students;
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> CREATE INDEX idx_age_name
    -> ON students(age, name);
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SHOW INDEX
    -> FROM students;
+----------+------------+--------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name     | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+--------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| students |          0 | PRIMARY      |            1 | id          | A         |           9 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| students |          1 | idx_name     |            1 | name        | A         |           9 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| students |          1 | idx_age_name |            1 | age         | A         |           9 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| students |          1 | idx_age_name |            2 | name        | A         |           9 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+----------+------------+--------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
4 rows in set (0.05 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age = 21;
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key          | key_len | ref   | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age_name  | idx_age_name | 5       | const |    2 |   100.00 | Using index |
+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
1 row in set, 1 warning (0.04 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age = 21
    -> AND name = 'Ali';
+----+-------------+----------+------------+------+-----------------------+----------+---------+-------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys         | key      | key_len | ref   | rows | filtered | Extra       |
+----+-------------+----------+------------+------+-----------------------+----------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_name,idx_age_name | idx_name | 203     | const |    1 |    11.11 | Using where |
+----+-------------+----------+------------+------+-----------------------+----------+---------+-------+------+----------+-------------+
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
1 row in set, 1 warning (0.00 sec)

mysql>


📝 Composite Index — Key Points to Remember
1. Definition

A Composite Index is an index created on two or more columns.

2. Column Order Matters ⭐⭐⭐⭐⭐
(age, name)

≠

(name, age)

The order of columns in a composite index is very important.

3. Leftmost Prefix Rule ⭐⭐⭐⭐⭐

A Composite Index works only if the query starts with the leftmost (first) column.

Example:

Index:

(age, name)

Works ✅

WHERE age = 21;
WHERE age = 21 AND name = 'Ali';

Does Not Work ❌

WHERE name = 'Ali';
4. MySQL Cost-Based Optimizer ⭐⭐⭐⭐⭐

MySQL does not always choose the Composite Index.

It chooses the lowest-cost (most efficient) index.

5. possible_keys

Shows all indexes that can be used.

6. key

Shows the index that MySQL actually used.

7. type = ref

Means MySQL is using a non-unique index to find matching rows.

8. type = ALL

Means Full Table Scan.

No suitable index is being used.

9. Using index

Means MySQL can return the required data using only the index without reading the full table.

This is called a Covering Index.

10. Composite Index is Best For
Multi-column WHERE
JOIN
ORDER BY
GROUP BY

when they use the same column order as the index.


## 📚 Topic 5: Unique Index

Run these commands:

CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(100)
);
CREATE UNIQUE INDEX idx_email
ON users(email);
SHOW INDEX FROM users;
INSERT INTO users VALUES
(1,'ali@gmail.com');
INSERT INTO users VALUES
(2,'ali@gmail.com');
EXPLAIN
SELECT *
FROM users
WHERE email='ali@gmail.com';


mysql> CREATE TABLE users (
    ->     id INT PRIMARY KEY,
    ->     email VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE UNIQUE INDEX idx_email
    -> ON users(email);
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> CREATE UNIQUE INDEX idx_email
    -> ON users(email);
ERROR 1061 (42000): Duplicate key name 'idx_email'
mysql> CREATE UNIQUE INDEX idx_email
    -> ON users(email);
ERROR 1061 (42000): Duplicate key name 'idx_email'
mysql> INSERT INTO users VALUES
    -> (2,'ali@gmail.com');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO users VALUES
    -> (2,'ali@gmail.com');
ERROR 1062 (23000): Duplicate entry '2' for key 'users.PRIMARY'
mysql> INSERT INTO users VALUES
    -> (3,'ali@gmail.com');
ERROR 1062 (23000): Duplicate entry 'ali@gmail.com' for key 'users.idx_email'
mysql>




🎯 Things to Remember (English)
Primary Key uniquely identifies each row.
Unique Index prevents duplicate values in a column.
A table can have only one Primary Key.
A table can have multiple Unique Indexes.
Both improve query performance.
Duplicate values generate ERROR 1062.
Primary Key automatically creates a unique index.