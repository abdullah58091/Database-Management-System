# DBMS Unit 4

✅ Transaction Management
✅ ACID Properties
✅ Transaction States
✅ Transaction Problems
✅ Concurrency Control
✅ Locking
✅ Timestamp Ordering
✅ Isolation Levels
Proper English
VS Code ready
GitHub ready
Interview ready
Tables, SQL examples, diagrams

## Topics Covered

- Concurrency Control
- Locking
- Timestamp Ordering Protocol
- Isolation Levels

---

# 1. Concurrency Control

## Definition

Concurrency Control is a mechanism that allows multiple transactions to execute simultaneously while maintaining database consistency and preventing conflicts.

## Why Concurrency Control is Needed

When multiple transactions access the same data at the same time, the following problems may occur:

- Lost Update
- Dirty Read
- Non-Repeatable Read
- Phantom Read
- Data Corruption

Concurrency Control ensures that concurrent transactions execute correctly without violating database consistency.

## Objectives

- Maintain Data Consistency
- Ensure Transaction Isolation
- Prevent Lost Updates
- Prevent Dirty Reads
- Improve Database Performance

## Example

Suppose an account balance is **₹10,000**.

Two users perform transactions simultaneously:

- User A withdraws ₹5,000
- User B withdraws ₹7,000

The database must control the execution order to avoid incorrect results.

## Concurrency Control Techniques

- Lock-Based Protocol
- Timestamp Ordering Protocol
- Multi-Version Concurrency Control (MVCC)

---

# 2. Locking

## Definition

Locking is a concurrency control technique that temporarily restricts access to a data item while a transaction is using it.

Only one transaction can modify locked data until the lock is released.

## Example

```sql
START TRANSACTION;

UPDATE Account
SET Balance = Balance - 5000
WHERE Account_ID = 101;

COMMIT;