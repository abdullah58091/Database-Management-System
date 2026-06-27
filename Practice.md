Enter password: ************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
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
5 rows in set (0.08 sec)

mysql> USE COLLEGE;
Database changed
mysql> SHOW TABLES ;
+-------------------+
| Tables_in_college |
+-------------------+
| marks             |
| students          |
+-------------------+
2 rows in set (0.05 sec)

mysql> SELECT * FROM STUDENT ;
ERROR 1146 (42S02): Table 'college.student' doesn't exist
mysql> SELECT * FROM students ;
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
10 rows in set (0.03 sec)

mysql>