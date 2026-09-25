
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
7 rows in set (0.08 sec)

mysql> USE company ;
Database changed
mysql> SHOW tables;
+-------------------+
| Tables_in_company |
+-------------------+
| departments       |
| employee          |
| employees         |
| meeting           |
+-------------------+
4 rows in set (0.01 sec)

mysql> SELECT * FROM employee;
+----+-------+------------+----------+
| id | name  | department | salary   |
+----+-------+------------+----------+
|  1 | Ali   | IT         | 60000.00 |
|  2 | John  | HR         | 45000.00 |
|  3 | Sara  | IT         | 75000.00 |
|  4 | David | Finance    | 55000.00 |
+----+-------+------------+----------+
4 rows in set (0.07 sec)

mysql> SELECT name
    -> FROM employee
    -> WHERE salary > 50000;
+-------+
| name  |
+-------+
| Ali   |
| Sara  |
| David |
+-------+
3 rows in set (0.04 sec)

mysql> EXPLAIN
    -> SELECT name
    -> FROM employee
    -> WHERE salary > 50000;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | employee | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    4 |    33.33 | Using where |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> SELECT e.name, d.department_name
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.department_id = d.id
    -> WHERE e.salary > 50000;
ERROR 1146 (42S02): Table 'company.department' doesn t exist
mysql> SELECT  e.name , d.deparment
    -> FROM Employee e
    -> JOIN Department d
    -> ON e.department_id = d.id
    -> WHERE e.salary > 50000;
ERROR 1146 (42S02): Table 'company.department' doesn t exist
mysql> DESC departments;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| dept_id         | int         | NO   | PRI | NULL    |       |
| department_name | varchar(30) | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
2 rows in set (0.02 sec)

mysql> DESC departments;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| dept_id         | int         | NO   | PRI | NULL    |       |
| department_name | varchar(30) | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> DESC employee;
+------------+---------------+------+-----+---------+-------+
| Field      | Type          | Null | Key | Default | Extra |
+------------+---------------+------+-----+---------+-------+
| id         | int           | NO   | PRI | NULL    |       |
| name       | varchar(100)  | YES  |     | NULL    |       |
| department | varchar(50)   | YES  |     | NULL    |       |
| salary     | decimal(10,2) | YES  |     | NULL    |       |
+------------+---------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> SELECT e.name, d.department_name
    -> FROM employee e
    -> JOIN departments d
    -> ON e.department = d.department_name
    -> WHERE e.salary > 50000;
+-------+-----------------+
| name  | department_name |
+-------+-----------------+
| Sara  | IT              |
| Ali   | IT              |
| David | Finance         |
+-------+-----------------+
3 rows in set (0.03 sec)

mysql> SELECT * FROM employee;
+----+-------+------------+----------+
| id | name  | department | salary   |
+----+-------+------------+----------+
|  1 | Ali   | IT         | 60000.00 |
|  2 | John  | HR         | 45000.00 |
|  3 | Sara  | IT         | 75000.00 |
|  4 | David | Finance    | 55000.00 |
+----+-------+------------+----------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM departments;
+---------+-----------------+
| dept_id | department_name |
+---------+-----------------+
|     101 | IT              |
|     102 | HR              |
|     103 | Finance         |
|     104 | Marketing       |
+---------+-----------------+
4 rows in set (0.00 sec)

mysql> EXPLAIN
    -> SELECT e.name, d.department_name
    -> FROM employee e
    -> JOIN departments d
    -> ON e.department = d.department_name
    -> WHERE e.salary > 50000;
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+--------------------------------------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                                      |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+--------------------------------------------+
|  1 | SIMPLE      | e     | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    4 |    33.33 | Using where                                |
|  1 | SIMPLE      | d     | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    4 |    25.00 | Using where; Using join buffer (hash join) |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+--------------------------------------------+
2 rows in set, 1 warning (0.00 sec)

mysql> CREATE INDEX idx_employee_salary
    -> ON employee(salary);
Query OK, 0 rows affected (0.13 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SHOW INDEX FROM employee;
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name            | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| employee |          0 | PRIMARY             |            1 | id          | A         |           4 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| employee |          1 | idx_employee_salary |            1 | salary      | A         |           4 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.01 sec)

mysql> SELECT *
    -> FROM employee
    -> WHERE salary = 75000;
+----+------+------------+----------+
| id | name | department | salary   |
+----+------+------------+----------+
|  3 | Sara | IT         | 75000.00 |
+----+------+------------+----------+
1 row in set (0.04 sec)

mysql> EXPLAIN
    -> SELECT e.name, d.department_name
    -> FROM employee e
    -> JOIN departments d
    -> ON e.department = d.department_name
    -> WHERE e.salary > 50000;
+----+-------------+-------+------------+-------+---------------------+---------------------+---------+------+------+----------+--------------------------------------------+
| id | select_type | table | partitions | type  | possible_keys       | key                 | key_len | ref  | rows | filtered | Extra                                      |
+----+-------------+-------+------------+-------+---------------------+---------------------+---------+------+------+----------+--------------------------------------------+
|  1 | SIMPLE      | e     | NULL       | range | idx_employee_salary | idx_employee_salary | 6       | NULL |    3 |   100.00 | Using index condition                      |
|  1 | SIMPLE      | d     | NULL       | ALL   | NULL                | NULL                | NULL    | NULL |    4 |    25.00 | Using where; Using join buffer (hash join) |
+----+-------------+-------+------------+-------+---------------------+---------------------+---------+------+------+----------+--------------------------------------------+
2 rows in set, 1 warning (0.03 sec)

mysql> CREATE TABLE department_salary_summary AS
    -> SELECT department, AVG(salary) AS average_salary
    -> FROM employee
    -> GROUP BY department;
Query OK, 3 rows affected (0.09 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT *
    -> FROM department_salary_summary;
+------------+----------------+
| department | average_salary |
+------------+----------------+
| IT         |   67500.000000 |
| HR         |   45000.000000 |
| Finance    |   55000.000000 |
+------------+----------------+
3 rows in set (0.00 sec)

mysql> TRUNCATE TABLE department_salary_summary;
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO department_salary_summary
    -> SELECT department, AVG(salary)
    -> FROM employee
    -> GROUP BY department;
Query OK, 3 rows affected (0.04 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee;
+----+-------+------------+----------+
| id | name  | department | salary   |
+----+-------+------------+----------+
|  1 | Ali   | IT         | 60000.00 |
|  2 | John  | HR         | 45000.00 |
|  3 | Sara  | IT         | 75000.00 |
|  4 | David | Finance    | 55000.00 |
+----+-------+------------+----------+
4 rows in set (0.00 sec)

mysql>