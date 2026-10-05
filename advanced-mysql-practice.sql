
mysql> USE company;
Database changed
mysql> SHOW TABLES;
+---------------------------+
| Tables_in_company         |
+---------------------------+
| department_salary_summary |
| departments               |
| employee                  |
| employees                 |
| meeting                   |
+---------------------------+
5 rows in set (0.19 sec)

mysql> DESC employee;
+------------+---------------+------+-----+---------+-------+
| Field      | Type          | Null | Key | Default | Extra |
+------------+---------------+------+-----+---------+-------+
| id         | int           | NO   | PRI | NULL    |       |
| name       | varchar(100)  | YES  |     | NULL    |       |
| department | varchar(50)   | YES  |     | NULL    |       |
| salary     | decimal(10,2) | YES  | MUL | NULL    |       |
| email      | varchar(100)  | YES  |     | NULL    |       |
+------------+---------------+------+-----+---------+-------+
5 rows in set (0.02 sec)

mysql> DESC departments;
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| dept_id         | int         | NO   | PRI | NULL    |       |
| department_name | varchar(30) | YES  |     | NULL    |       |
+-----------------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

mysql> DESC employees;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| id         | int         | NO   | PRI | NULL    |       |
| name       | varchar(50) | YES  |     | NULL    |       |
| age        | int         | YES  |     | NULL    |       |
| salary     | int         | YES  |     | NULL    |       |
| department | varchar(30) | YES  |     | NULL    |       |
| dept_id    | int         | YES  |     | NULL    |       |
| manager_id | int         | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
7 rows in set (0.00 sec)

mysql> DESC meeting;SELECT * FROM employee;
+--------------+--------------+------+-----+---------+-------+
| Field        | Type         | Null | Key | Default | Extra |
+--------------+--------------+------+-----+---------+-------+
| meeting_id   | int          | NO   | PRI | NULL    |       |
| meeting_name | varchar(100) | YES  |     | NULL    |       |
| meeting_date | date         | YES  |     | NULL    |       |
| meeting_time | time         | YES  |     | NULL    |       |
| location     | varchar(100) | YES  |     | NULL    |       |
+--------------+--------------+------+-----+---------+-------+
5 rows in set (0.01 sec)

+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  1 | Ali   | IT         | 70000.00 | NULL  |
|  2 | John  | HR         | 45000.00 | NULL  |
|  3 | Sara  | IT         | 75000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
+----+-------+------------+----------+-------+
4 rows in set (0.04 sec)

mysql> SELECT * FROM departments;
+---------+-----------------+
| dept_id | department_name |
+---------+-----------------+
|     101 | IT              |
|     102 | HR              |
|     103 | Finance         |
|     104 | Marketing       |
+---------+-----------------+
4 rows in set (0.02 sec)

mysql> SELECT name, salary FROM employee;
+-------+----------+
| name  | salary   |
+-------+----------+
| Ali   | 70000.00 |
| John  | 45000.00 |
| Sara  | 75000.00 |
| David | 55000.00 |
+-------+----------+
4 rows in set (0.00 sec)

mysql> SELECT name, department FROM employee;
+-------+------------+
| name  | department |
+-------+------------+
| Ali   | IT         |
| John  | HR         |
| Sara  | IT         |
| David | Finance    |
+-------+------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM employee;
+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  1 | Ali   | IT         | 70000.00 | NULL  |
|  2 | John  | HR         | 45000.00 | NULL  |
|  3 | Sara  | IT         | 75000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
+----+-------+------------+----------+-------+
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

mysql> SELECT name, salary FROM employee;
+-------+----------+
| name  | salary   |
+-------+----------+
| Ali   | 70000.00 |
| John  | 45000.00 |
| Sara  | 75000.00 |
| David | 55000.00 |
+-------+----------+
4 rows in set (0.00 sec)

mysql> SELECT name, department FROM employee;
+-------+------------+
| name  | department |
+-------+------------+
| Ali   | IT         |
| John  | HR         |
| Sara  | IT         |
| David | Finance    |
+-------+------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM employee ORDER BY salary ASC;
+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  2 | John  | HR         | 45000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
|  1 | Ali   | IT         | 70000.00 | NULL  |
|  3 | Sara  | IT         | 75000.00 | NULL  |
+----+-------+------------+----------+-------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM employee ORDER BY salary DESC;
+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  3 | Sara  | IT         | 75000.00 | NULL  |
|  1 | Ali   | IT         | 70000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
|  2 | John  | HR         | 45000.00 | NULL  |
+----+-------+------------+----------+-------+
4 rows in set (0.00 sec)

mysql> SELECT COUNT(*) FROM employee;
+----------+
| COUNT(*) |
+----------+
|        4 |
+----------+
1 row in set (0.04 sec)

mysql> SELECT MAX(salary) FROM employee;
+-------------+
| MAX(salary) |
+-------------+
|    75000.00 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(salary) FROM employee;
+-------------+
| MIN(salary) |
+-------------+
|    45000.00 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(salary) FROM employee;
+--------------+
| AVG(salary)  |
+--------------+
| 61250.000000 |
+--------------+
1 row in set (0.03 sec)

mysql> SELECT SUM(salary) FROM employee;
+-------------+
| SUM(salary) |
+-------------+
|   245000.00 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT department, COUNT(*)
    -> FROM employee
    -> GROUP BY department;
+------------+----------+
| department | COUNT(*) |
+------------+----------+
| IT         |        2 |
| HR         |        1 |
| Finance    |        1 |
+------------+----------+
3 rows in set (0.00 sec)

mysql> SELECT department, COUNT(*)
    -> FROM employee
    -> GROUP BY department;
+------------+----------+
| department | COUNT(*) |
+------------+----------+
| IT         |        2 |
| HR         |        1 |
| Finance    |        1 |
+------------+----------+
3 rows in set (0.00 sec)

mysql> SELECT e.name, d.department_name, e.salary
    -> FROM employee e
    -> JOIN departments d
    -> ON e.department = d.department_name;
+-------+-----------------+----------+
| name  | department_name | salary   |
+-------+-----------------+----------+
| Sara  | IT              | 75000.00 |
| Ali   | IT              | 70000.00 |
| John  | HR              | 45000.00 |
| David | Finance         | 55000.00 |
+-------+-----------------+----------+
4 rows in set (0.04 sec)

mysql> SELECT e.name, d.department_name, e.salary
    -> FROM employee e
    -> JOIN departments d
    -> ON e.department = d.department_name
    -> WHERE e.salary > 50000;
+-------+-----------------+----------+
| name  | department_name | salary   |
+-------+-----------------+----------+
| Sara  | IT              | 75000.00 |
| Ali   | IT              | 70000.00 |
| David | Finance         | 55000.00 |
+-------+-----------------+----------+
3 rows in set (0.04 sec)

mysql> SELECT DISTINCT department
    -> FROM employee;
+------------+
| department |
+------------+
| IT         |
| HR         |
| Finance    |
+------------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM employee
    -> WHERE name LIKE 'A%';
+----+------+------------+----------+-------+
| id | name | department | salary   | email |
+----+------+------------+----------+-------+
|  1 | Ali  | IT         | 70000.00 | NULL  |
+----+------+------------+----------+-------+
1 row in set (0.04 sec)

mysql> SELECT * FROM employee
    -> WHERE name LIKE '%a%';
+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  1 | Ali   | IT         | 70000.00 | NULL  |
|  3 | Sara  | IT         | 75000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
+----+-------+------------+----------+-------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM employee
    -> WHERE name LIKE '%a%';
+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  1 | Ali   | IT         | 70000.00 | NULL  |
|  3 | Sara  | IT         | 75000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
+----+-------+------------+----------+-------+
3 rows in set (0.00 sec)

mysql> INSERT INTO employee
    -> (id, name, department, salary)
    -> VALUES
    -> (5, 'Aman', 'Marketing', 48000);
Query OK, 1 row affected (0.05 sec)

mysql> SELECT * FROM employee;
+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  1 | Ali   | IT         | 70000.00 | NULL  |
|  2 | John  | HR         | 45000.00 | NULL  |
|  3 | Sara  | IT         | 75000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
|  5 | Aman  | Marketing  | 48000.00 | NULL  |
+----+-------+------------+----------+-------+
5 rows in set (0.00 sec)

mysql>
mysql> SELECT * FROM employee;
+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  1 | Ali   | IT         | 70000.00 | NULL  |
|  2 | John  | HR         | 45000.00 | NULL  |
|  3 | Sara  | IT         | 75000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
|  5 | Aman  | Marketing  | 48000.00 | NULL  |
+----+-------+------------+----------+-------+
5 rows in set (0.00 sec)

mysql> UPDATE employee
    -> SET salary = 50000
    -> WHERE id = 5;
Query OK, 1 row affected (0.05 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM employee
    -> WHERE id = 5;
Query OK, 1 row affected (0.04 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> UPDATE employee
    -> SET salary = salary + 1000
    -> WHERE id = 1;
Query OK, 1 row affected (0.03 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> SELECT * FROM employee
    -> WHERE id = 1;
+----+------+------------+----------+-------+
| id | name | department | salary   | email |
+----+------+------------+----------+-------+
|  1 | Ali  | IT         | 71000.00 | NULL  |
+----+------+------------+----------+-------+
1 row in set (0.00 sec)

mysql>
mysql> ROLLBACK;
Query OK, 0 rows affected (0.01 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> UPDATE employee
    -> SET salary = salary + 500
    -> WHERE id = 1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> COMMIT;
Query OK, 0 rows affected (0.01 sec)

mysql>