
mysql> USE COMPANY;
Database changed
mysql> SELECT name, salary
    -> FROM employee
    -> WHERE salary > 50000;
+-------+----------+
| name  | salary   |
+-------+----------+
| David | 55000.00 |
| Ali   | 60000.00 |
| Sara  | 75000.00 |
+-------+----------+
3 rows in set (0.00 sec)

mysql> SELECT name, department
    -> FROM employee
    -> WHERE salary > 50000;
+-------+------------+
| name  | department |
+-------+------------+
| David | Finance    |
| Ali   | IT         |
| Sara  | IT         |
+-------+------------+
3 rows in set (0.00 sec)

mysql> EXPLAIN
    -> SELECT name, department
    -> FROM employee
    -> WHERE salary > 50000;
+----+-------------+----------+------------+-------+---------------------+---------------------+---------+------+------+----------+-----------------------+
| id | select_type | table    | partitions | type  | possible_keys       | key                 | key_len | ref  | rows | filtered | Extra                 |
+----+-------------+----------+------------+-------+---------------------+---------------------+---------+------+------+----------+-----------------------+
|  1 | SIMPLE      | employee | NULL       | range | idx_employee_salary | idx_employee_salary | 6       | NULL |    3 |   100.00 | Using index condition |
+----+-------------+----------+------------+-------+---------------------+---------------------+---------+------+------+----------+-----------------------+
1 row in set, 1 warning (0.04 sec)

mysql>

mysql> UPDATE employee
    -> SET salary = 80000
    -> WHERE id = 1;
Query OK, 1 row affected (0.07 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT *
    -> FROM employee
    -> WHERE id = 1;
+----+------+------------+----------+
| id | name | department | salary   |
+----+------+------------+----------+
|  1 | Ali  | IT         | 80000.00 |
+----+------+------------+----------+
1 row in set (0.03 sec)

mysql>


mysql> SELECT *
    -> FROM employee
    -> WHERE department = 'IT';
+----+------+------------+----------+
| id | name | department | salary   |
+----+------+------------+----------+
|  1 | Ali  | IT         | 80000.00 |
|  3 | Sara | IT         | 75000.00 |
+----+------+------------+----------+
2 rows in set (0.03 sec)

mysql> SELECT *
    -> FROM employee
    -> WHERE department = 'HR';
+----+------+------------+----------+
| id | name | department | salary   |
+----+------+------------+----------+
|  2 | John | HR         | 45000.00 |
+----+------+------------+----------+
1 row in set (0.00 sec)

mysql>mysql> SELECT department, COUNT(*) AS employee_count
    -> FROM employee
    -> GROUP BY department;
+------------+----------------+
| department | employee_count |
+------------+----------------+
| IT         |              2 |
| HR         |              1 |
| Finance    |              1 |
+------------+----------------+
3 rows in set (0.01 sec)

mysql>







