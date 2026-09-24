
mysql> SHOW DATABASES ;
+--------------------+
| Database           |
+--------------------+
| college            |
| company            |
| information_schema |
| log_sentinel       |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
7 rows in set (0.04 sec)

mysql> USE COMPANY ;
Database changed
mysql> SHOW TABLES;
+-------------------+
| Tables_in_company |
+-------------------+
| departments       |
| employees         |
| meeting           |
+-------------------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM departments;
+---------+-----------------+
| dept_id | department_name |
+---------+-----------------+
|     101 | IT              |
|     102 | HR              |
|     103 | Finance         |
|     104 | Marketing       |
+---------+-----------------+
4 rows in set (0.08 sec)

mysql>  SELECT * FROM employees;
+----+----------+------+--------+------------+---------+------------+
| id | name     | age  | salary | department | dept_id | manager_id |
+----+----------+------+--------+------------+---------+------------+
|  1 | Abdullah |   21 |  50000 | IT         |     101 |       NULL |
|  2 |          |   20 |  45000 | HR         |     102 |          1 |
|  3 | Sara     |   20 |  60000 | IT         |     101 |          1 |
|  4 | Zoya     |   25 |  70000 | Finance    |     103 |          1 |
|  5 | Aman     |   22 |  55000 | IT         |     101 |          2 |
|  6 | John     |   28 |  80000 | Finance    |     103 |          2 |
|  7 | Ali      |   24 |  48000 | HR         |     102 |          3 |
|  8 | Rohan    |   27 |  75000 | IT         |     101 |          3 |
|  9 | David    |   26 |  52000 | Unknown    |     999 |          3 |
| 10 | Ravi     |   45 |  34000 | HR         |     102 |          1 |
+----+----------+------+--------+------------+---------+------------+
10 rows in set (0.03 sec)

mysql>

mysql> CREATE TABLE Employee (
    ->     id INT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     department VARCHAR(50),
    ->     salary DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.18 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| college            |
| company            |
| information_schema |
| log_sentinel       |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
7 rows in set (0.00 sec)

mysql> USE COMPANY;
Database changed
mysql> SHOW COMPANY ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'COMPANY' at line 1
mysql> SHOW TABLES;
+-------------------+
| Tables_in_company |
+-------------------+
| departments       |
| employee          |
| employees         |
| meeting           |
+-------------------+
4 rows in set (0.00 sec)

mysql> USE COLLEGE;
Database changed
mysql> SHOW TABLES;
+-------------------+
| Tables_in_college |
+-------------------+
| employees         |
| marks             |
| student_view      |
| students          |
| subjects          |
| teachers          |
| users             |
+-------------------+
7 rows in set (0.00 sec)

mysql> SELECT DATABASE();
+------------+
| DATABASE() |
+------------+
| college    |
+------------+
1 row in set (0.00 sec)

mysql> USE company ;
Database changed
mysql> SHOW TABLES;
+-------------------+
| Tables_in_company |
+-------------------+
| departments       |
| employee          |
| employees         |
| meeting           |
+-------------------+
4 rows in set (0.00 sec)

mysql> DESCRIBE employee;
+------------+---------------+------+-----+---------+-------+
| Field      | Type          | Null | Key | Default | Extra |
+------------+---------------+------+-----+---------+-------+
| id         | int           | NO   | PRI | NULL    |       |
| name       | varchar(100)  | YES  |     | NULL    |       |
| department | varchar(50)   | YES  |     | NULL    |       |
| salary     | decimal(10,2) | YES  |     | NULL    |       |
+------------+---------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

mysql> INSERT INTO Employee
    -> VALUES
    -> (1, 'Ali', 'IT', 60000),
    -> (2, 'John', 'HR', 45000),
    -> (3, 'Sara', 'IT', 75000),
    -> (4, 'David', 'Finance', 55000);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT name,Salary FROM Empolyee
    -> WHERE salary >50000;
ERROR 1146 (42S02): Table 'company.empolyee' doesn t exist
mysql> SELECT * FROM company.employee;
+----+-------+------------+----------+
| id | name  | department | salary   |
+----+-------+------------+----------+
|  1 | Ali   | IT         | 60000.00 |
|  2 | John  | HR         | 45000.00 |
|  3 | Sara  | IT         | 75000.00 |
|  4 | David | Finance    | 55000.00 |
+----+-------+------------+----------+
4 rows in set (0.00 sec)

mysql> SELECT name, salary
    -> FROM company.employee
    -> WHERE salary >50000;
+-------+----------+
| name  | salary   |
+-------+----------+
| Ali   | 60000.00 |
| Sara  | 75000.00 |
| David | 55000.00 |
+-------+----------+
3 rows in set (0.00 sec)

mysql> SELECT name, salary
    -> FROM Employee
    -> WHERE salary > 50000;
+-------+----------+
| name  | salary   |
+-------+----------+
| Ali   | 60000.00 |
| Sara  | 75000.00 |
| David | 55000.00 |
+-------+----------+
3 rows in set (0.00 sec)

mysql> EXPLAIN
    -> SELECT name,salary
    -> FROM company.employee
    -> WHERE salary > 50000;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | employee | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    4 |    33.33 | Using where |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> SELECT *
    -> FROM logs
    -> WHERE severity = 'ERROR'
    -> AND created_at >= '2026-09-01';
ERROR 1146 (42S02): Table 'company.logs' doesn t exist
mysql>