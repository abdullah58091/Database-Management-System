
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

class Solution {
    public int[] arrayRankTransform(int[] arr) {
        int[] temp = Arrays.copyOf(arr, arr.length);

        Arrays.sort(temp);

        int rank = 1;
        HashMap<Integer, Integer> hm = new HashMap<>();

        for (int ele : temp) {
            if (!hm.containsKey(ele)) {
                hm.put(ele, rank++);
            }
        }

        for (int i = 0; i < arr.length; i++) {
            arr[i] = hm.get(arr[i]);
        }

        return arr;
    }
}