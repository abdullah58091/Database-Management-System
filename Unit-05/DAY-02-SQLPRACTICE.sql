💻 Practical 

Run these commands one by one:

1.
EXPLAIN
SELECT *
FROM students
WHERE age = 22;
2.
EXPLAIN
SELECT *
FROM students
WHERE id = 3;
3.
EXPLAIN
SELECT *
FROM students
WHERE age >= 21;
4.
EXPLAIN
SELECT *
FROM students
WHERE age <= 19;


    -> FROM students
    -> WHERE age = 21;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   21 |
|  4 | Ali      |   21 |
+----+----------+------+
2 rows in set (0.01 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age = 22;
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age       | idx_age | 5       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.04 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE id = 3;
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.04 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age >= 21;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | ALL  | idx_age       | NULL | NULL    | NULL |    9 |   100.00 | Using where |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.04 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age <= 19;
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                 |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
|  1 | SIMPLE      | students | NULL       | range | idx_age       | idx_age | 5       | NULL |    2 |   100.00 | Using index condition |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
1 row in set, 1 warning (0.00 sec)

mysql>

## these queries ka output samjho aur niche diye gaye table me fill karo:

Query 1
SELECT *
FROM students
WHERE age = 22;

Output:

type = ref
key = idx_age
rows = 1
Optimizer ne kya socha?
WHERE age = 22

↓

Age par index hai? ✅

↓

Haan

↓

Index kholo

↓

22 wali row nikalo

↓

Done
Conclusion
✅ Index use hua.
✅ Sirf 1 row dekhni padi.
✅ Fast query.
Query 2
SELECT *
FROM students
WHERE id = 3;

Output:

type = const
key = PRIMARY
rows = 1
Optimizer ne kya socha?
WHERE id = 3

↓

id Primary Key hai? ✅

↓

Haan

↓

Seedha Row 3

↓

Done
Conclusion

Ye sabse fast query hai.

Kyun?

id unique hai.
Primary Key par index automatic hota hai.
Sirf 1 row read hui.
Query 3
SELECT *
FROM students
WHERE age >= 21;

Output:

type = ALL
key = NULL

Ab sawal:

Index to bana hua hai, phir use kyu nahi hua?

Chalo table dekhte hain.

Age
21
18
25
21
19
22
34
45
33
56
23

Condition:

age >= 21

Kitni rows match karti hain?

21 ✅
25 ✅
21 ✅
22 ✅
34 ✅
45 ✅
33 ✅
56 ✅
23 ✅

9 out of 11 rows!

Optimizer sochta hai:

Mujhe waise bhi lagbhag poori table padhni hai.

↓

Index use karne ka fayda kam hai.

↓

Full Table Scan hi kar leta hoon.

Isliye:

type = ALL
key = NULL
Query 4
SELECT *
FROM students
WHERE age <= 19;

Output:

type = range
key = idx_age
rows = 2

Table me:

18 ✅
19 ✅

Bas 2 rows.

Optimizer sochta hai:

Sirf 2 rows chahiye.

↓

Index use karna sasta padega.

↓

Range Scan karo.

Isliye:

type = range
key = idx_age
📊 Ab saari queries compare karo
Query	type	Index Use?	Reason
age = 22	ref	✅ Yes	Exact value, normal index
id = 3	const	✅ Yes	Primary Key
age >= 21	ALL	❌ No	Almost poori table match kar rahi hai
age <= 19	range	✅ Yes	Sirf chhota range match kar raha hai



## .📚 Topic 2: ORDER BY Optimization practical

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> ORDER BY age;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
|  1 | SIMPLE      | students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
1 row in set, 1 warning (0.04 sec)


mysql> SELECT * FROM students
    -> ORDER BY students;
ERROR 1054 (42S22): Unknown column 'students' in 'order clause'
mysql> SELECT *
    -> FROM students
    -> ORDER BY age;
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
11 rows in set (0.05 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> ORDER BY age DESC;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
|  1 | SIMPLE      | students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> ORDER BY name;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
|  1 | SIMPLE      | students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
1 row in set, 1 warning (0.01 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age = 21
    -> ORDER BY age;
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | ref  | idx_age       | idx_age | 5       | const |    2 |   100.00 | NULL  |
+----+-------------+----------+------------+------+---------------+---------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql>

// 

Query 1
EXPLAIN
SELECT *
FROM students
ORDER BY age DESC;

Output:

type = ALL
key = NULL
Extra = Using filesort
Optimizer ne kya socha?
ORDER BY age DESC

↓

Poori table padhni padegi

↓

Sorting karni padegi

↓

Using filesort
Kyun?
Tumne saari rows maangi.
Table chhoti hai (11 rows).
Optimizer ko laga ki table read + sort karna index use karne se sasta hai.
Query 2
EXPLAIN
SELECT *
FROM students
ORDER BY name;

Output:

type = ALL
key = NULL
Extra = Using filesort
Kyun?

Sabse pehle socho:

name par koi index hai?

👉 Nahi.

To optimizer ke paas choice hi nahi hai.

Usko karna padega:

Table Read

↓

Sort by name

↓

Result

Isliye:

Using filesort

Ye expected output hai.

Query 3 ⭐ (Sabse Important)
EXPLAIN
SELECT *
FROM students
WHERE age = 21
ORDER BY age;

Output:

type = ref
key = idx_age
Extra = NULL
Ye bahut achha output hai.

Optimizer ne socha:

WHERE age = 21

↓

Index use karo

↓

Sirf age = 21 ki rows lao

↓

ORDER BY age ?

Ab dhyan do.

Jo rows aayi hain:

21
21

Ye pehle se hi age ke hisaab se sorted hain.

Ab database ko alag se sort karne ki zarurat hi nahi.

Isliye:

Extra = NULL

Using filesort nahi aaya.

Visual Samjho
Case 1
ORDER BY age;

Data:

21
18
25
21
19
22

Database:

Read

↓

Sort

↓

Result

Using filesort

Case 2
WHERE age = 21
ORDER BY age;

Index:

21

↓

21

Already sorted.

Database:

Read Index

↓

Done

No sorting.

Important Rule
Agar
WHERE

aur

ORDER BY

same indexed column par ho,

to MySQL aksar extra sorting se bach sakta hai.

Isi wajah se:

Extra = NULL
Professional Definition

If the filtering column and sorting column use the same index, MySQL can often return rows in sorted order directly from the index, avoiding an additional sort operation.

Interview Question
Q. Why is Using filesort not shown in this query?
SELECT *
FROM students
WHERE age = 21
ORDER BY age;

Answer:

Because MySQL uses the idx_age index for filtering, and the rows retrieved from the index are already in the required order. Therefore, no additional sorting operation is needed.

📊 Compare All ORDER BY Queries
Query	Index Used	Extra	Reason
ORDER BY age	❌ No	Using filesort	Full table + sorting
ORDER BY age DESC	❌ No	Using filesort	Full table + sorting
ORDER BY name	❌ No	Using filesort	No index on name
WHERE age=21 ORDER BY age	✅ Yes (idx_age)	NULL	Index already returns sorted rows



##


mysql> SELECT *
    -> FROM students
    -> LIMIT 5;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   21 |
|  2 | Iram     |   18 |
|  3 | Arsh     |   25 |
|  4 | Ali      |   21 |
|  5 | Sara     |   19 |
+----+----------+------+
5 rows in set (0.01 sec)

mysql> SELECT *
    -> FROM students
    -> ORDER BY age DESC
    -> LIMIT 3;
+----+-------+------+
| id | name  | age  |
+----+-------+------+
| 10 | Ajaye |   56 |
|  8 | saif  |   45 |
|  7 | pooja |   34 |
+----+-------+------+
3 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM students
    -> ORDER BY age DESC
    -> LIMIT 5;
+----+-------+------+
| id | name  | age  |
+----+-------+------+
| 10 | Ajaye |   56 |
|  8 | saif  |   45 |
|  7 | pooja |   34 |
|  9 | Jhon  |   33 |
|  3 | Arsh  |   25 |
+----+-------+------+
5 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM students
    -> LIMIT 0,5;
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   21 |
|  2 | Iram     |   18 |
|  3 | Arsh     |   25 |
|  4 | Ali      |   21 |
|  5 | Sara     |   19 |
+----+----------+------+
5 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM students
    -> LIMIT 5,5;
+----+-------+------+
| id | name  | age  |
+----+-------+------+
|  6 | Zoya  |   22 |
|  7 | pooja |   34 |
|  8 | saif  |   45 |
|  9 | Jhon  |   33 |
| 10 | Ajaye |   56 |
+----+-------+------+
5 rows in set (0.01 sec)


mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> LIMIT 5;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------+
|  1 | SIMPLE      | students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | NULL  |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------+
1 row in set, 1 warning (0.01 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> ORDER BY age DESC
    -> LIMIT 3;
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
|  1 | SIMPLE      | students | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    9 |   100.00 | Using filesort |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
1 row in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE age > 18
    -> LIMIT 2;
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                 |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
|  1 | SIMPLE      | students | NULL       | range | idx_age       | idx_age | 5       | NULL |   10 |   100.00 | Using index condition |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------+
1 row in set, 1 warning (0.01 sec)

mysql> SELECT *
    -> FROM students
    -> LIMIT 5,3;
+----+-------+------+
| id | name  | age  |
+----+-------+------+
|  6 | Zoya  |   22 |
|  7 | pooja |   34 |
|  8 | saif  |   45 |
+----+-------+------+
3 rows in set (0.00 sec)

mysql>

//

Query 2
EXPLAIN
SELECT *
FROM students
ORDER BY age DESC
LIMIT 3;

Output:

type = ALL
Extra = Using filesort
Kyun?

Bahut log sochte hain:

"LIMIT 3 hai, to database sirf 3 rows padhega."

❌ Ye hamesha sahi nahi hai.

Pehle database ko ye pata lagana padega ki sabse badi age kiski hai.

Process:

Read all rows

↓

Sort by age DESC

↓

56
45
34
33
...

↓

Top 3 return

Isliye:

Using filesort
Query 3 ⭐
EXPLAIN
SELECT *
FROM students
WHERE age > 18
LIMIT 2;

Output:

type = range
key = idx_age
Extra = Using index condition
Ye best query hai.

Optimizer:

WHERE age >18

↓

Index available ✅

↓

Range Scan

↓

2 rows mil gayi

↓

Stop

Yahan LIMIT ka asli fayda mila.

📊 Summary
Query	                    type	Extra	                       Optimizer Decision
LIMIT 5     	            ALL 	NULL	                    Read rows, stop after 5
ORDER BY age DESC LIMIT 3	ALL	    Using filesort	Sort        first, then return top 3
WHERE age > 18 LIMIT 2	    range	Using index condition	    Use index, stop after 2
LIMIT 5,3	                —	    —	                        Skip first 5, return next 3




## 📚 GROUP BY Optimization
5. Aggregate Functions
Function	Kaam
COUNT()	Rows count
SUM()	Total
AVG()	Average
MAX()	Largest
MIN()	Smallest



🧪 Practical (Run These)
Query 1
SELECT age,
COUNT(*)
FROM students
GROUP BY age;
Query 2
EXPLAIN
SELECT age,
COUNT(*)
FROM students
GROUP BY age;
Query 3
SELECT age,
MAX(age)
FROM students
GROUP BY age;
Query 4
EXPLAIN
SELECT age
FROM students
GROUP BY age;



mysql> SELECT age,
    -> COUNT(*)
    -> FROM students
    -> GROUP BY age;
+------+----------+
| age  | COUNT(*) |
+------+----------+
|   18 |        1 |
|   19 |        1 |
|   21 |        2 |
|   22 |        1 |
|   23 |        1 |
|   25 |        1 |
|   33 |        1 |
|   34 |        1 |
|   45 |        1 |
|   56 |        1 |
+------+----------+
10 rows in set (0.01 sec)

mysql> EXPLAIN
    -> SELECT age,
    -> COUNT(*)
    -> FROM students
    -> GROUP BY age;
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | index | idx_age       | idx_age | 5       | NULL |    9 |   100.00 | Using index |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> SELECT age,
    -> MAX(age)
    -> FROM students
    -> GROUP BY age;
+------+----------+
| age  | MAX(age) |
+------+----------+
|   18 |       18 |
|   19 |       19 |
|   21 |       21 |
|   22 |       22 |
|   23 |       23 |
|   25 |       25 |
|   33 |       33 |
|   34 |       34 |
|   45 |       45 |
|   56 |       56 |
+------+----------+
10 rows in set (0.00 sec)

mysql> EXPLAIN
    -> SELECT age
    -> FROM students
    -> GROUP BY age;
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | index | idx_age       | idx_age | 5       | NULL |    9 |   100.00 | Using index |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql>


Query 2 ⭐
EXPLAIN
SELECT age,
COUNT(*)
FROM students
GROUP BY age;

Output:

type = index
key = idx_age
Extra = Using index

Ye sabse important output hai.

1. type = index
Professional Definition

MySQL scans the entire index instead of scanning the full table.

Hinglish

Database bol raha hai:

"Mujhe poori table padhne ki zarurat nahi."

"Main sirf idx_age index padh lunga."

Ye ALL se better hota hai.

2. key = idx_age

Matlab:

Age Index

↓

18

19

21

21

22

23

...

Database ne age index use kiya.

3. Extra = Using index

Ye bahut important hai.

Professional Definition

Using index means MySQL can satisfy the query using only the index without reading the full table rows.

Hinglish

Database bol raha hai:

"Jo data chahiye tha, wo mujhe index me hi mil gaya."

Table kholne ki zarurat nahi padi.

Ye bahut fast hota hai.

| Query                         | type    | Extra                 | Meaning           |
| ----------------------------- | ------- | --------------------- | ----------------- |
| `WHERE age = 21`              | `ref`   | NULL                  | Index lookup      |
| `WHERE age BETWEEN 20 AND 30` | `range` | Using index condition | Range scan        |
| `GROUP BY age`                | `index` | Using index           | Full index scan   |
| `ORDER BY age`                | `ALL`   | Using filesort        | Table scan + sort |




## 📚 Topic 5: HAVING Clause

mysql> SELECT age, COUNT(*)
    -> FROM students
    -> GROUP BY age
    -> HAVING COUNT(*) > 1;
+------+----------+
| age  | COUNT(*) |
+------+----------+
|   21 |        2 |
+------+----------+
1 row in set (0.00 sec)

mysql> EXPLAIN
    -> SELECT age, COUNT(*)
    -> FROM students
    -> GROUP BY age
    -> HAVING COUNT(*) > 1;
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | students | NULL       | index | idx_age       | idx_age | 5       | NULL |    9 |   100.00 | Using index |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.04 sec)

mysql> SELECT age, COUNT(*)
    -> FROM students
    -> WHERE age > 20
    -> GROUP BY age;
+------+----------+
| age  | COUNT(*) |
+------+----------+
|   21 |        2 |
|   22 |        1 |
|   23 |        1 |
|   25 |        1 |
|   33 |        1 |
|   34 |        1 |
|   45 |        1 |
|   56 |        1 |
+------+----------+
8 rows in set (0.00 sec)

mysql> SELECT age, COUNT(*)
    -> FROM students
    -> GROUP BY age
    -> HAVING age > 20;
+------+----------+
| age  | COUNT(*) |
+------+----------+
|   21 |        2 |
|   22 |        1 |
|   23 |        1 |
|   25 |        1 |
|   33 |        1 |
|   34 |        1 |
|   45 |        1 |
|   56 |        1 |
+------+----------+
8 rows in set (0.00 sec)

mysql>

Interview Question ⭐⭐⭐⭐⭐
Which is better?
WHERE age >20
GROUP BY age;

OR

GROUP BY age
HAVING age >20;
Answer

If the condition does not depend on an aggregate function, use WHERE because it filters rows before grouping, reducing the amount of data MySQL has to process.

Golden Rule (Yaad Kar Lo)
Use	Clause
Row filter	WHERE
Group filter	HAVING



## 📚 Topic 6: EXISTS vs IN

mysql> SELECT * FROM marks;
+------+-------+
| id   | marks |
+------+-------+
|    1 |    80 |
|    2 |    90 |
|    4 |    70 |
|    1 |    90 |
|    3 |    80 |
|    5 |    95 |
|   11 |    70 |
+------+-------+
7 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM students
    -> WHERE id IN (
    ->     SELECT id
    ->     FROM marks
    -> );
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   21 |
|  2 | Iram     |   18 |
|  4 | Ali      |   21 |
|  3 | Arsh     |   25 |
|  5 | Sara     |   19 |
| 11 | Sadik    |   23 |
+----+----------+------+
6 rows in set (0.04 sec)

mysql> SELECT *
    -> FROM students s
    -> WHERE EXISTS (
    ->     SELECT *
    ->     FROM marks m
    ->     WHERE s.id = m.id
    -> );
+----+----------+------+
| id | name     | age  |
+----+----------+------+
|  1 | Abdullah |   21 |
|  2 | Iram     |   18 |
|  4 | Ali      |   21 |
|  3 | Arsh     |   25 |
|  5 | Sara     |   19 |
| 11 | Sadik    |   23 |
+----+----------+------+
6 rows in set (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students
    -> WHERE id IN (
    ->     SELECT id
    ->     FROM marks
    -> );
+----+--------------+-------------+------------+--------+---------------+---------+---------+----------------+------+----------+-------------+
| id | select_type  | table       | partitions | type   | possible_keys | key     | key_len | ref            | rows | filtered | Extra       |
+----+--------------+-------------+------------+--------+---------------+---------+---------+----------------+------+----------+-------------+
|  1 | SIMPLE       | <subquery2> | NULL       | ALL    | NULL          | NULL    | NULL    | NULL           | NULL |   100.00 | Using where |
|  1 | SIMPLE       | students    | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | <subquery2>.id |    1 |   100.00 | NULL        |
|  2 | MATERIALIZED | marks       | NULL       | ALL    | NULL          | NULL    | NULL    | NULL           |    7 |   100.00 | NULL        |
+----+--------------+-------------+------------+--------+---------------+---------+---------+----------------+------+----------+-------------+
3 rows in set, 1 warning (0.00 sec)

mysql> EXPLAIN
    -> SELECT *
    -> FROM students s
    -> WHERE EXISTS (
    ->     SELECT *
    ->     FROM marks m
    ->     WHERE s.id = m.id
    -> );
+----+--------------+-------------+------------+--------+---------------+---------+---------+----------------+------+----------+-------------+
| id | select_type  | table       | partitions | type   | possible_keys | key     | key_len | ref            | rows | filtered | Extra       |
+----+--------------+-------------+------------+--------+---------------+---------+---------+----------------+------+----------+-------------+
|  1 | SIMPLE       | <subquery2> | NULL       | ALL    | NULL          | NULL    | NULL    | NULL           | NULL |   100.00 | Using where |
|  1 | SIMPLE       | s           | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | <subquery2>.id |    1 |   100.00 | NULL        |
|  2 | MATERIALIZED | m           | NULL       | ALL    | NULL          | NULL    | NULL    | NULL           |    7 |   100.00 | NULL        |
+----+--------------+-------------+------------+--------+---------------+---------+---------+----------------+------+----------+-------------+
3 rows in set, 2 warnings (0.04 sec)




// ya se samjho ki IN aur EXISTS dono same output de rahe hain, lekin optimizer ka plan thoda alag hai. 
IN query me subquery ko materialize karke marks table ko read kiya ja raha hai, jabki EXISTS me bhi similar approach hai.
 Dono cases me students table ke liye PRIMARY key ka use ho raha hai.


mysql>
IN Query
SELECT *
FROM students
WHERE id IN (
SELECT id
FROM marks
);

Output ka important part:

select_type = MATERIALIZED
table = marks

## 🤔 Ye MATERIALIZED kya hai?
Professional Definition

A materialized subquery means MySQL executes the subquery once, stores its result in a temporary internal table, and then uses that temporary result for the outer query.


eq_ref

Ye bhi naya type dekha tumne.

type = eq_ref
Professional Definition

eq_ref is used when MySQL finds exactly one matching row using a unique or primary key for each row from the previous table.

| Type   | Speed      |
| ------ | ---------- |
| system | ⭐⭐⭐⭐⭐      |
| const  | ⭐⭐⭐⭐⭐      |
| eq_ref | ⭐⭐⭐⭐       |
| ref    | ⭐⭐⭐        |
| range  | ⭐⭐         |
| index  | ⭐          |
| ALL    | 😭 Slowest |


## 📚 Topic 7: UNION vs UNION ALL