
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
7 rows in set (0.01 sec)

mysql> USE COMPANY;
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
5 rows in set (0.01 sec)

mysql> SELECT customer_name, transaction_amount
    -> FROM Customer
    -> JOIN Transaction
    -> ON Customer.customer_id = Transaction.customer_id;
ERROR 1146 (42S02): Table 'company.customer' doesnt exist
mysql> SELECT e.name, d.department_name
    -> FROM employee e
    -> JOIN departments d
    -> ON e.department = d.department_name;
+-------+-----------------+
| name  | department_name |
+-------+-----------------+
| Sara  | IT              |
| Ali   | IT              |
| John  | HR              |
| David | Finance         |
+-------+-----------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM company.employee
    -> WHERE department = 'IT';
+----+------+------------+----------+
| id | name | department | salary   |
+----+------+------------+----------+
|  1 | Ali  | IT         | 60000.00 |
|  3 | Sara | IT         | 75000.00 |
+----+------+------------+----------+
2 rows in set (0.00 sec)

mysql> SELECT id, name, salary FROM employee;
+----+-------+----------+
| id | name  | salary   |
+----+-------+----------+
|  1 | Ali   | 60000.00 |
|  2 | John  | 45000.00 |
|  3 | Sara  | 75000.00 |
|  4 | David | 55000.00 |
+----+-------+----------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM EMPLOYEE;
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