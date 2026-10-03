
mysql> USE company;
Database changed
mysql>
mysql> SELECT department, COUNT(*) AS employee_count
    -> FROM employee
    -> GROUP BY department;
+------------+----------------+
| department | employee_count |
+------------+----------------+
| IT         |              2 |
| HR         |              1 |
| Finance    |              1 |
+------------+----------------+
3 rows in set (0.10 sec)