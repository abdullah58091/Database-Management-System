## 📚 Topic 2: Primary Index
1. Professional Definition (English)

A Primary Index is an index automatically created on the Primary Key of a table. It allows MySQL to uniquely identify and quickly access each row using the primary key value.

Since every Primary Key must contain unique and non-NULL values, the Primary Index provides the fastest way to retrieve a single row.

6. Advantages

✅ Fastest Search

✅ Automatically Created

✅ Unique Values

✅ NULL Allowed Nahi

✅ Fast JOIN Performance

✅ Fast Foreign Key Lookup

7. Disadvantages

Primary Index ke zyada disadvantages nahi hote, lekin kuch limitations hain.

❌ Sirf ek Primary Index ho sakta hai.

❌ Primary Key duplicate nahi ho sakti.

❌ NULL value allowed nahi hoti.

❌ Primary Key change karna expensive operation ho sakta hai bade tables me.

8. Interview Questions
Q1. What is a Primary Index?

Answer:

A Primary Index is an index automatically created on the Primary Key column to uniquely identify and efficiently retrieve rows.

Q2. Is Primary Index created automatically?

Answer:

Yes.

Whenever a Primary Key is defined, MySQL automatically creates a Primary Index.

Q3. Can a table have multiple Primary Indexes?

Answer:

No.

A table can have only one Primary Key, therefore only one Primary Index.

Q4. Can Primary Key contain NULL values?

Answer:

No.

Primary Key columns cannot contain NULL values.

Q5. Is Primary Index always unique?

Answer:

Yes.

Every Primary Key value must be unique.

## 📚 Topic 3: Secondary Index
1. Professional Definition (English)

A Secondary Index is an index created on one or more non-primary key columns to improve the speed of data retrieval operations.

Unlike the Primary Index, a Secondary Index does not require the indexed values to be unique.

## Example

Student Table

id	name	age
1	Abdullah	21
2	Iram	18
3	Arsh	25
4	Ali	21
5	Sara	19

Agar hum baar-baar age ke basis par search karte hain:

SELECT *
FROM students
WHERE age = 21;

To hum age par Secondary Index bana dete hain.

## 6. Advantages

✅ Fast WHERE Queries

✅ Fast JOIN

✅ Fast ORDER BY

✅ Fast GROUP BY

✅ Better Performance on Large Tables

7. Disadvantages

Har column par index nahi banana chahiye.

Kyun?

Har INSERT ke time:

New Row

↓

Table Update

↓

Index Update

Isliye

❌ INSERT Slow

❌ UPDATE Slow

❌ DELETE Slow

❌ Storage Extra Lagti Hai

Agar 20 columns par index bana doge to database slow ho jayega.

## 8. Interview Questions
Q1. What is a Secondary Index?

Answer:

A Secondary Index is an index created on a non-primary key column to improve query performance.

Q2. Is Secondary Index created automatically?

Answer:

No.

It must be created manually using CREATE INDEX.

Q3. Can a table have multiple Secondary Indexes?

Answer:

Yes.

Ek table me multiple Secondary Indexes ho sakte hain.

Example:

CREATE INDEX idx_age
ON students(age);

CREATE INDEX idx_name
ON students(name);

CREATE INDEX idx_city
ON students(city);
Q4. Can Secondary Index contain duplicate values?

Answer:

Yes.

Example:

Age

21

21

21

22

22

23

Duplicates allowed hain.



1. Professional Definition (English)

A Composite Index is an index created on two or more columns of a table. It improves query performance when queries frequently filter, sort, or join using the same combination of columns.

Unlike a single-column index, a Composite Index stores the values of multiple columns together in a specific order.

## 6. Advantages

✅ Faster Multi-Column Search

✅ Better JOIN Performance

✅ Better ORDER BY

✅ Better GROUP BY

✅ Less Disk Reads

7. Disadvantages

❌ Extra Storage

❌ INSERT thoda slow

❌ UPDATE thoda slow

❌ DELETE thoda slow

❌ Agar galat order me banaya to index ka fayda nahi milega.

## 8. Interview Questions
Q1. What is a Composite Index?

Answer:

A Composite Index is an index created on two or more columns to improve the performance of queries that use those columns together.

Q2. What is the Leftmost Prefix Rule?

Answer:

A Composite Index can be used only when the query starts with the leftmost indexed column.

Q3. Is (age, name) same as (name, age)?

Answer:

❌ No.

Order matters.

(age, name)

≠

(name, age)
Q4. Can Composite Index improve ORDER BY?

Answer:

Yes.

If the ORDER BY follows the same column order as the index.

## 📚 Topic 5: Unique Index
1. Professional Definition (English)

A Unique Index is an index that ensures all values in the indexed column (or combination of columns) are unique while also improving query performance.

It prevents duplicate values from being inserted into the indexed column.

## 6. Advantages

✅ Prevents Duplicate Data

✅ Fast Search

✅ Improves Data Integrity

✅ Better Query Performance

7. Disadvantages

❌ Extra Storage

❌ INSERT thoda slow

❌ UPDATE thoda slow

❌ DELETE thoda slow


## 8. Interview Questions
Q1. What is a Unique Index?

Answer:

A Unique Index is an index that enforces uniqueness on the indexed column while improving query performance.

Q2. Can a Unique Index contain duplicate values?

Answer:

No.

Duplicate values are not allowed.

Q3. Can a table have multiple Unique Indexes?

Answer:

Yes.

A table can have multiple Unique Indexes on different columns.

Q4. Does Unique Index improve search performance?

Answer:

Yes.

It improves both data integrity and query performance.

Q5. Is Unique Index automatically created?

Answer:

No.

It is created manually using CREATE UNIQUE INDEX or by defining a UNIQUE constraint.