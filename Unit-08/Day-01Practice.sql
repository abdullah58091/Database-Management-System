tabase changed
mysql>
mysql> DESC employee;
+------------+---------------+------+-----+---------+-------+
| Field      | Type          | Null | Key | Default | Extra |
+------------+---------------+------+-----+---------+-------+
| id         | int           | NO   | PRI | NULL    |       |
| name       | varchar(100)  | YES  |     | NULL    |       |
| department | varchar(50)   | YES  |     | NULL    |       |
| salary     | decimal(10,2) | YES  | MUL | NULL    |       |
+------------+---------------+------+-----+---------+-------+
4 rows in set (0.09 sec)

mysql> ALTER TABLE employee
    -> ADD email VARCHAR(100);
Query OK, 0 rows affected (0.15 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee;
+----+-------+------------+----------+-------+
| id | name  | department | salary   | email |
+----+-------+------------+----------+-------+
|  1 | Ali   | IT         | 80000.00 | NULL  |
|  2 | John  | HR         | 45000.00 | NULL  |
|  3 | Sara  | IT         | 75000.00 | NULL  |
|  4 | David | Finance    | 55000.00 | NULL  |
+----+-------+------------+----------+-------+
4 rows in set (0.00 sec)

mysql> employee:1 → Ali
    -> {
    ->   "id": 1,
    ->   "name": "Ali",
    ->   "department": "IT",
    ->   "salary": 60000
    -> }
    -> {
    ->   "id": 1,
    ->   "name": "Ali",
    ->   "department": "IT",
    ->   "salary": 60000
    -> }
    -> [Ali] ──WORKS_IN──> [IT]
    -> ^C
mysql> USE company;
Database changed
mysql>
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> UPDATE employee
    -> SET salary = salary + 1000
    -> WHERE id = 1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> SELECT *
    -> FROM employee
    -> WHERE id = 1;
+----+------+------------+----------+-------+
| id | name | department | salary   | email |
+----+------+------------+----------+-------+
|  1 | Ali  | IT         | 81000.00 | NULL  |
+----+------+------------+----------+-------+
1 row in set (0.00 sec)

mysql>
mysql> COMMIT;
Query OK, 0 rows affected (0.01 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> UPDATE employee
    -> SET salary = salary + 5000
    -> WHERE id = 1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

mysql>