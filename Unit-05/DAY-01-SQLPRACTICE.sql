## 💻 Today's Practical (MySQL)

## Run these commands:

 SELECT * FROM students;

SELECT * FROM students WHERE student_id = 5;

EXPLAIN
SELECT * FROM students WHERE student_id = 5;

EXPLAIN
SELECT * FROM students WHERE age > 18;

SHOW INDEX FROM students;



EXPLAIN
SELECT * FROM students
WHERE age > 18;


+----+-------------+----------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | type | possible_keys | key  | rows | filtered | Extra       |
+----+-------------+----------+------+---------------+------+---------+------+------+----------+-------------+
| 1  | SIMPLE      | students | ALL  | NULL          | NULL | 9    | 33.33    | Using where |
+----+-------------+----------+------+---------------+------+---------+------+------+----------+-------------+


1. id
Professional Definition (English)

The id column represents the execution order of SELECT statements in a query.

Hinglish

Ye batata hai query ka step number.

Tumhari query me sirf ek SELECT hai.

Isliye

id = 1

Agar query me subquery hoti ya multiple SELECT hote, to multiple IDs dikhte.

✅ Matlab:

Query sirf ek step me execute hogi.

2. select_type
Professional Definition

The select_type column indicates the type of SELECT query being executed.

Tumhare output me

SIMPLE

Matlab

koi JOIN nahi
koi Subquery nahi
koi UNION nahi

Bas ek normal SELECT.

Ye sabse common type hai.

3. table
students

Matlab optimizer kis table ko read karega.

Simple.

4. type ⭐⭐⭐⭐⭐ (Very Important)

Ye sabse important column hai.

Professional Definition

The type column shows how MySQL accesses rows from the table.

Tumhare output me

ALL

Iska matlab

Full Table Scan

Database har row ko check karega.

Row1

↓

Row2

↓

Row3

↓

Row4

↓

...

↓

Last Row

Phir dekhega

age >18 ?

True?

Return.

False?

Skip.

Kya ye achha hai?

❌ Nahi.

Large table me bahut slow ho sakta hai.

Ye isliye hua kyunki age column par index nahi hai.

5. possible_keys

Tumhare output me

NULL

Matlab

Optimizer bol raha hai

"Mere paas koi index available hi nahi hai."

Isliye

Table Scan.

6. key

Output

NULL

Matlab

Koi index use nahi hua.

7. rows

Output

9

Ye exact count nahi hota.

Ye optimizer ka estimated number hai ki kitni rows scan karni pad sakti hain.

Tumhari table me 11 rows hain, estimate 9 dikh raha hai. Chhoti table me estimates exact nahi bhi ho sakte.

8. filtered

Output

33.33

Meaning

Optimizer estimate karta hai ki scan ki gayi rows me se lagbhag itne percent rows condition pass karengi.

Ye bhi estimate hota hai.

9. Extra

Output

Using where

Matlab

Database WHERE condition apply karega.

Yani

age>18

check karega.

