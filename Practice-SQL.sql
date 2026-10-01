
mysql> SHOW DATABASE;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'DATABASE' at line 1
mysql> SHOW DATABASES ;
+--------------------+
| Database           |
+--------------------+
| college            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.03 sec)

mysql> USE COLLEGE ;
Database changed
mysql> SHOW TABLES ;
+-------------------+
| Tables_in_college |
+-------------------+
| marks             |
| students          |
+-------------------+
2 rows in set (0.01 sec)

mysql> SECLECT * FROM students ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SECLECT * FROM students' at line 1
mysql> SELECT * FROM students ;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   21 |
|  2 | Iram     |   18 |
|  3 | Arsh     |   25 |
|  4 | Ali      |   21 |
|  5 | Sara     |   19 |
|  6 | Zoya     |   22 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
|  9 | Jhon     |   33 |
| 10 | Ajaye    |   56 |
| 11 | Sadik    |   23 |
+----+----------+------+
11 rows in set (0.02 sec)

mysql> SELECT * FROM students
    -> WHERE students_id = 5;
ERROR 1054 (42S22): Unknown column 'students_id' in 'where clause'
mysql> SELECT * FROM students
    -> WHERE student_id = 5;
ERROR 1054 (42S22): Unknown column 'student_id' in 'where clause'
mysql> SELECT * FROM students WHERE student_id = 5;
ERROR 1054 (42S22): Unknown column 'student_id' in 'where clause'
mysql> SELECT * FROM students
    -> WHERE id = 5;
+----+------+------+
| id | name | age  |
+----+------+------+
|  5 | Sara |   19 |
+----+------+------+
1 row in set (0.00 sec)

mysql> EXPLAIN
    -> SELECT * FROM students
    -> WHERE age > 18;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |    33.33 | Using where |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT * FROM students
    -> WHERE id = 5;
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> CREATE INDEX idx_age ON students(age);
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> EXPLAIN
    -> SELECT * FROM students
    -> WHERE age > 18;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ALL  | idx_age       | NULL | NULL    | NULL |    9 |   100.00 | Using where |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT * FROM students
    -> WHERE age = 56;
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age       | idx_age | 5       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT * FROM students
    -> WHERE age = 21;
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age       | idx_age | 5       | const |    2 |   100.00 | NULL  |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT * FROM students
    -> WHERE id = 10;
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT * FROM students
    -> WHERE age BETWEEN 20 AND 30;
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                 |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
|  1 | SIMPLE      | students | NULL       | range | idx_age       | idx_age | 5       | NULL |    5 |   100.00 | Using index condition |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
1 row in set, 1 warning (0.04 sec)

mysql> EXPLAIN
    -> SELECT * FROM students
    -> WHERE age < 20;
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                 |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
|  1 | SIMPLE      | students | NULL       | range | idx_age       | idx_age | 5       | NULL |    2 |   100.00 | Using index condition |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
1 row in set, 1 warning (0.00 sec)

mysql>



Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES ;
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

mysql> USE COLLEGE ;
Database changed
mysql> SHOW TABLES ;
+-------------------+
| Tables_in_college |
+-------------------+
| marks             |
| students          |
| users             |
+-------------------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM students ;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  2 | Iram     |   18 |
|  5 | Sara     |   19 |
|  1 | Abdullah |   21 |
|  4 | Ali      |   21 |
|  6 | Zoya     |   22 |
| 11 | Sadik    |   23 |
|  3 | Arsh     |   25 |
|  9 | Jhon     |   33 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
| 10 | Ajaye    |   56 |
+----+----------+------+
11 rows in set (0.00 sec)

mysql> SELECT
    -> * FROM STUDENTNS;
ERROR 1146 (42S02): Table 'college.studentns doesn't exist
mysql> SELECT *
    -> FROM students
    -> ORDER BY age ASC;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  2 | Iram     |   18 |
|  5 | Sara     |   19 |
|  1 | Abdullah |   21 |
|  4 | Ali      |   21 |
|  6 | Zoya     |   22 |
| 11 | Sadik    |   23 |
|  3 | Arsh     |   25 |
|  9 | Jhon     |   33 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
| 10 | Ajaye    |   56 |
+----+----------+------+
11 rows in set (0.03 sec)

mysql> SELECT *
    -> FROM students
    -> ORDER BY id ASC;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   21 |
|  2 | Iram     |   18 |
|  3 | Arsh     |   25 |
|  4 | Ali      |   21 |
|  5 | Sara     |   19 |
|  6 | Zoya     |   22 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
|  9 | Jhon     |   33 |
| 10 | Ajaye    |   56 |
| 11 | Sadik    |   23 |
+----+----------+------+
11 rows in set (0.00 sec)




11/07/2026


Enter password: ************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 14
Server version: 8.0.46 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show  databases;
+--------------------+
| Database           |
+--------------------+
| college            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.05 sec)

mysql> use college;
Database changed
mysql> show tales;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'tales' at line 1
mysql> SHOW tables ;
+-------------------+
| Tables_in_college |
+-------------------+
| marks             |
| students          |
| users             |
+-------------------+
3 rows in set (0.03 sec)

mysql> SELECT * FROM students ;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  2 | Iram     |   18 |
|  5 | Sara     |   19 |
|  1 | Abdullah |   21 |
|  4 | Ali      |   21 |
|  6 | Zoya     |   22 |
| 11 | Sadik    |   23 |
|  3 | Arsh     |   25 |
|  9 | Jhon     |   33 |
|  7 | pooja    |   34 |
|  8 | saif     |   45 |
| 10 | Ajaye    |   56 |
+----+----------+------+
11 rows in set (0.00 sec)

mysql>

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

mysql> USE log_sentinel;
Database changed
mysql> SELECT
    ->     id,
    ->     title,
    ->     description,
    ->     severity,
    ->     status,
    ->     related_log_id,
    ->     created_at,
    ->     updated_at
    -> FROM incidents
    -> ORDER BY id DESC;
+----+----------------------------------------------------------------+--------------------------------------------------------+----------+----------+----------------+----------------------------+----------------------------+
| id | title                                                          | description                                            | severity | status   | related_log_id | created_at                 | updated_at                 |
+----+----------------------------------------------------------------+--------------------------------------------------------+----------+----------+----------------+----------------------------+----------------------------+
|  2 | Automatic Incident: Payment service database connection failed | Payment service database connection failed             | HIGH     | OPEN     |             10 | 2026-09-30 10:17:25.175733 | 2026-09-30 10:17:25.175733 |
|  1 | Database Connection Failure                                    | Payment service is unable to connect to MySQL database | CRITICAL | RESOLVED |              0 | 2026-09-06 00:00:34.470745 | 2026-09-06 00:00:34.470745 |
+----+----------------------------------------------------------------+--------------------------------------------------------+----------+----------+----------------+----------------------------+----------------------------+
2 rows in set (0.00 sec)

mysql> SELECT
    ->     l.id,
    ->     l.level,
    ->     l.message,
    ->     l.source
    -> FROM logs l
    -> LEFT JOIN incidents i
    ->     ON l.id = i.related_log_id
    -> WHERE i.id IS NULL
    -> ORDER BY l.id;
+----+-------+--------------------------------------------+-----------------+
| id | level | message                                    | source          |
+----+-------+--------------------------------------------+-----------------+
|  5 | ERROR | Database connection failed                 | Payment-Service |
|  7 | ERROR | Payment service database connection failed | Payment-Service |
|  8 | ERROR | Payment service database connection failed | Payment-Service |
|  9 | ERROR | Payment service database connection failed | payment-service |
+----+-------+--------------------------------------------+-----------------+
4 rows in set (0.00 sec)

mysql> SELECT
    ->     id,
    ->     title,
    ->     severity,
    ->     status,
    ->     related_log_id,
    ->     created_at,
    ->     updated_at
    -> FROM incidents
    -> ORDER BY id;
+----+----------------------------------------------------------------+----------+----------+----------------+----------------------------+----------------------------+
| id | title                                                          | severity | status   | related_log_id | created_at                 | updated_at                 |
+----+----------------------------------------------------------------+----------+----------+----------------+----------------------------+----------------------------+
|  1 | Database Connection Failure                                    | CRITICAL | RESOLVED |              0 | 2026-09-06 00:00:34.470745 | 2026-09-06 00:00:34.470745 |
|  2 | Automatic Incident: Payment service database connection failed | HIGH     | OPEN     |             10 | 2026-09-30 10:17:25.175733 | 2026-09-30 10:17:25.175733 |
|  4 | Manual Database Incident                                       | HIGH     | OPEN     |              5 | 2026-09-30 10:30:06.568867 | 2026-09-30 10:30:06.568867 |
|  5 | Manual Database Incident 2                                     | HIGH     | OPEN     |              7 | 2026-09-30 10:33:16.231447 | 2026-09-30 10:33:16.231447 |
+----+----------------------------------------------------------------+----------+----------+----------------+----------------------------+----------------------------+
4 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM logs
    -> WHERE id = 0;
Empty set (0.00 sec)

mysql> DELETE FROM incidents
    -> WHERE id = 1;
Query OK, 1 row affected (0.01 sec)

mysql> SELECT id, username, email, role
    -> FROM users;
+----+-----------+---------------------+------+
| id | username  | email               | role |
+----+-----------+---------------------+------+
|  1 | abdullah  | abdullah@gmail.com  | USER |
|  2 | abdullah2 | abdullah2@gmail.com | USER |
+----+-----------+---------------------+------+
2 rows in set (0.03 sec)

mysql> SELECT  id, username, email ,role
    -> FROM log_sentinel.users;
+----+-----------+---------------------+------+
| id | username  | email               | role |
+----+-----------+---------------------+------+
|  1 | abdullah  | abdullah@gmail.com  | USER |
|  2 | abdullah2 | abdullah2@gmail.com | USER |
+----+-----------+---------------------+------+
2 rows in set (0.00 sec)

mysql> SELECT id, username, role
    -> FROM log_sentinel.users;
+----+-----------+------+
| id | username  | role |
+----+-----------+------+
|  1 | abdullah  | USER |
|  2 | abdullah2 | USER |
+----+-----------+------+
2 rows in set (0.00 sec)

mysql> UPDATE log_sentinel.users
    -> SET role = 'ADMIN'
    -> WHERE id = 1;
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> UPDATE log_sentinel.users
    -> SET role = 'DEVELOPER'
    -> WHERE id = 2;
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT id, username, role
    -> FROM log_sentinel.users;
+----+-----------+-----------+
| id | username  | role      |
+----+-----------+-----------+
|  1 | abdullah  | ADMIN     |
|  2 | abdullah2 | DEVELOPER |
+----+-----------+-----------+
2 rows in set (0.00 sec)

mysql> SELECT username, password, role
    -> FROM log_sentinel.users
    -> WHERE username = 'abdullah';
+----------+--------------------------------------------------------------+-------+
| username | password                                                     | role  |
+----------+--------------------------------------------------------------+-------+
| abdullah | $2a$........................................................ | ADMIN |
+----------+--------------------------------------------------------------+-------+
1 row in set (0.00 sec)

mysql> UPDATE log_sentinel.users
    -> SET role = 'ADMIN'
    -> WHERE username = 'admin_test';
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT id, username, role
    -> FROM log_sentinel.users
    -> WHERE username = 'admin_test';
+----+------------+-------+
| id | username   | role  |
+----+------------+-------+
|  4 | admin_test | ADMIN |
+----+------------+-------+
1 row in set (0.00 sec)

mysql> SELECT
    ->     id,
    ->     title,
    ->     severity,
    ->     status,
    ->     related_log_id
    -> FROM log_sentinel.incidents
    -> ORDER BY id;
+----+----------------------------------------------------------------+----------+----------+----------------+
| id | title                                                          | severity | status   | related_log_id |
+----+----------------------------------------------------------------+----------+----------+----------------+
|  2 | Automatic Incident: Payment service database connection failed | HIGH     | RESOLVED |             10 |
|  4 | Manual Database Incident                                       | HIGH     | RESOLVED |              5 |
|  6 | Automatic Incident: Payment database connection failed         | HIGH     | OPEN     |             11 |
+----+----------------------------------------------------------------+----------+----------+----------------+
3 rows in set (0.00 sec)

mysql> SELECT
    ->     id,
    ->     level,
    ->     message,
    ->     source
    -> FROM log_sentinel.logs
    -> ORDER BY id;
+----+-------+--------------------------------------------+-----------------+
| id | level | message                                    | source          |
+----+-------+--------------------------------------------+-----------------+
|  5 | ERROR | Database connection failed                 | Payment-Service |
|  7 | ERROR | Payment service database connection failed | Payment-Service |
|  8 | ERROR | Payment service database connection failed | Payment-Service |
|  9 | ERROR | Payment service database connection failed | payment-service |
| 10 | ERROR | Payment service database connection failed | payment-service |
| 11 | ERROR | Payment database connection failed         | payment-service |
+----+-------+--------------------------------------------+-----------------+
6 rows in set (0.00 sec)

mysql> SELECT
    ->     id,
    ->     title,
    ->     severity,
    ->     status,
    ->     related_log_id
    -> FROM log_sentinel.incidents
    -> ORDER BY id;
+----+----------------------------------------------------------------+----------+----------+----------------+
| id | title                                                          | severity | status   | related_log_id |
+----+----------------------------------------------------------------+----------+----------+----------------+
|  2 | Automatic Incident: Payment service database connection failed | HIGH     | RESOLVED |             10 |
|  4 | Manual Database Incident                                       | HIGH     | RESOLVED |              5 |
|  6 | Automatic Incident: Payment database connection failed         | HIGH     | OPEN     |             11 |
| 11 | Manual Payment Incident                                        | HIGH     | OPEN     |              7 |
+----+----------------------------------------------------------------+----------+----------+----------------+
4 rows in set (0.00 sec)

mysql> select u1_0.id
    -> from users u1_0
    -> where u1_0.username=?
    -> ^C
mysql> SELECT id, username, role
    -> FROM log_sentinel.users;
+----+--------------+-----------+
| id | username     | role      |
+----+--------------+-----------+
|  1 | abdullah     | ADMIN     |
|  2 | abdullah2    | DEVELOPER |
|  3 | auth_test    | DEVELOPER |
|  4 | admin_test   | ADMIN     |
|  5 | auth_test_01 | DEVELOPER |
+----+--------------+-----------+
5 rows in set (0.00 sec)

mysql> UPDATE log_sentinel.users
    -> SET role = 'ADMIN'
    -> WHERE username = 'auth_test_01';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT id, username, role
    -> FROM log_sentinel.users
    -> WHERE username = 'auth_test_01';
+----+--------------+-------+
| id | username     | role  |
+----+--------------+-------+
|  5 | auth_test_01 | ADMIN |
+----+--------------+-------+
1 row in set (0.00 sec)

mysql>
