-- ```sql
-- -- =========================================
-- -- SQL TASK 2 - COMPLETE CODE NOTES
-- -- =========================================


# DBMS Practice - Day 2

Topics Covered:

- SQL Joins
  - INNER JOIN
  - LEFT JOIN
  - RIGHT JOIN

- Aggregate Functions
  - COUNT()
  - SUM()
  - AVG()
  - MAX()
  - MIN()

- DDL Commands
  - CREATE
  - ALTER
  - DROP
  - TRUNCATE

Practice Database:
- college
- students table
- marks table

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
5 rows in set (0.01 sec)

mysql> USE COLLEGE;
Database changed
mysql> SHOW TABLES;
+-------------------+
| Tables_in_college |
+-------------------+
| students          |
+-------------------+
1 row in set (0.00 sec)

mysql> SELECT name FROM students;;
+----------+
| name     |
+----------+
| Abdullah |
| Aman     |
| Arsh     |
| Ali      |
| Sara     |
| Zoya     |
| pooja    |
| saif     |
| Jhon     |
+----------+
9 rows in set (0.00 sec)

ERROR:
No query specified

mysql> SELECT * FROM students ;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   20 |
|  2 | Aman     |   24 |
|  3 | Arsh     |   25 |
|  4 | Ali      |   21 |
|  5 | Sara     |   19 |
|  6 | Zoya     |   22 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
|  9 | Jhon     |   33 |
+----+----------+------+
9 rows in set (0.00 sec)

mysql> INSERT INTO students(id,name,age)
    -> VALUES (10,'Ajaye',56);
Query OK, 1 row affected (0.02 sec)

mysql> UPDATE TABLES name
    -> SET name = IRAM
    -> WHERE id = 2;
ERROR 1146 (42S02): Table 'college.tables' doesn't exist
mysql> UPDATE COLLEGE TABLES
    -> SET name = IRAM
    -> WHERE id = 2;
ERROR 1146 (42S02): Table 'college.college' doesn't exist
mysql> UPDATE students
    -> SET  name = IRAM
    -> WHERE id = 2;
ERROR 1054 (42S22): Unknown column 'IRAM' in 'field list'
mysql> UPDATE students
    -> SET name = 'IRAM'
    -> WHERE id = 2;
Query OK, 1 row affected (0.05 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM students;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   20 |
|  2 | IRAM     |   24 |
|  3 | Arsh     |   25 |
|  4 | Ali      |   21 |
|  5 | Sara     |   19 |
|  6 | Zoya     |   22 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
|  9 | Jhon     |   33 |
| 10 | Ajaye    |   56 |
+----+----------+------+
10 rows in set (0.04 sec)

mysql> UPDATE students
    -> SET age = 18
    -> WHERE id = 2;
Query OK, 1 row affected (0.05 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE students
    -> SET  name = 'Iram'
    -> WHERE id = 2;
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM students;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   20 |
|  2 | Iram     |   18 |
|  3 | Arsh     |   25 |
|  4 | Ali      |   21 |
|  5 | Sara     |   19 |
|  6 | Zoya     |   22 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
|  9 | Jhon     |   33 |
| 10 | Ajaye    |   56 |
+----+----------+------+
10 rows in set (0.00 sec)

mysql> SELECT COUNT(*) FROM students;
+----------+
| COUNT(*) |
+----------+
|       10 |
+----------+
1 row in set (0.06 sec)

mysql> SELECT AVG(age) FROM students;
+----------+
| AVG(age) |
+----------+
|  29.3000 |
+----------+
1 row in set (0.05 sec)

mysql> SELECT MAX(age) FROM students;
+----------+
| MAX(age) |
+----------+
|       56 |
+----------+
1 row in set (0.04 sec)

mysql>
mysql> SELECT MIN(age) FROM students;
+----------+
| MIN(age) |
+----------+
|       18 |
+----------+
1 row in set (0.00 sec)

mysql> CREATE TABLE marks(
    -> id INT,
    -> marks INT
    -> );
Query OK, 0 rows affected (0.12 sec)

mysql> SELECT * FROM students;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   20 |
|  2 | Iram     |   18 |
|  3 | Arsh     |   25 |
|  4 | Ali      |   21 |
|  5 | Sara     |   19 |
|  6 | Zoya     |   22 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
|  9 | Jhon     |   33 |
| 10 | Ajaye    |   56 |
+----+----------+------+
10 rows in set (0.00 sec)

mysql> INSERT INTO marks VALUES(1,80);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO marks VALUES(2,90);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO marks VALUES(4,70);
Query OK, 1 row affected (0.04 sec)

mysql> SELECT students.name, marks.marks
    -> FROM students
    -> INNER JOIN marks
    -> ON students.id = marks.id;
+----------+-------+
| name     | marks |
+----------+-------+
| Abdullah |    80 |
| Iram     |    90 |
| Ali      |    70 |
+----------+-------+
3 rows in set (0.00 sec)

mysql> SELECT students.name , marks.marks
    -> FROM students
    -> LEFT JOIN marks
    -> ON students.id = marks.id;
+----------+-------+
| name     | marks |
+----------+-------+
| Abdullah |    80 |
| Iram     |    90 |
| Arsh     |  NULL |
| Ali      |    70 |
| Sara     |  NULL |
| Zoya     |  NULL |
| pooja    |  NULL |
| saif     |  NULL |
| Jhon     |  NULL |
| Ajaye    |  NULL |
+----------+-------+
10 rows in set (0.00 sec)

mysql> SELECT students.name, marks.marks
    -> FROM students
    -> RIGHT JOIN marks
    -> ON students.id = marks.id;
+----------+-------+
| name     | marks |
+----------+-------+
| Abdullah |    80 |
| Iram     |    90 |
| Ali      |    70 |
+----------+-------+
3 rows in set (0.00 sec)

mysql> SELECT SUM(age) FROM students;
+----------+
| SUM(age) |
+----------+
|      293 |
+----------+
1 row in set (0.00 sec)

mysql>