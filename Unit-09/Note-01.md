#### Multi-Version Concurrency Control (MVCC)
1. Definition ⭐

Multi-Version Concurrency Control (MVCC) is a concurrency control technique in which a database maintains multiple versions of a data item so that multiple transactions can access data concurrently without unnecessary blocking.

2. Explanation — What, Why, How ⭐
What is MVCC?

MVCC maintains different versions of data when transactions modify it.

Why is MVCC used?

It is used to:

Allow multiple transactions to execute simultaneously.
Reduce conflicts between reading and writing.
Provide consistent data to readers.
Improve database performance.
How does MVCC work?

When a transaction updates a data item, the database creates a new version instead of immediately removing the old version.

          Data Item
             |
      ┌──────┴──────┐
      ↓             ↓
 Old Version     New Version
   ₹5000            ₹7000
      ↑               ↑
   Reader          Writer

A transaction can read the appropriate version according to its transaction view, while another transaction can update the data.

3. Important Concepts ⭐
Old Version

The previous value of a data item maintained for transactions that still need to see it.

New Version

The updated value created by a modifying transaction.

Consistent Read

A transaction reads a consistent version of data without being unnecessarily blocked by another transaction.

4. Advantages ⭐
Reduces blocking between readers and writers.
Improves concurrency because multiple transactions can work simultaneously.
Provides consistent reads.
Improves performance for applications with many read operations.
Useful in multi-user database systems.
5. Disadvantages ⭐
Requires additional storage for multiple versions.
Managing old versions increases system complexity.
Old versions must eventually be removed.
Version management can add processing overhead.
6. Example

Suppose an employee's salary is:

Initial Salary = ₹60,000

Transaction T1 is reading the salary.

At the same time, Transaction T2 changes it:

Old Version → ₹60,000
New Version → ₹70,000

T1 can continue using the appropriate version while T2 works with the new version.

Conceptual example — do not run this diagram in MySQL.

7. 10-Mark Exam Answer ⭐⭐⭐

Multi-Version Concurrency Control (MVCC) is a concurrency control technique used in database systems to manage multiple transactions by maintaining different versions of data items.

In traditional locking, a read operation may be blocked when another transaction is writing the same data. MVCC reduces this problem by maintaining multiple versions of the data.

When a transaction updates a data item, a new version is created while the previous version may be retained for transactions that still require it. Therefore, readers can access a consistent version of the data while writers work on a newer version.

For example, if an employee's salary changes from ₹60,000 to ₹70,000, the database may temporarily maintain both versions:

Old Version → ₹60,000
New Version → ₹70,000

The major advantages of MVCC are reduced blocking, better concurrency, consistent reads, and improved performance. However, it requires additional storage and version-management overhead.

Thus, MVCC improves concurrent transaction processing by allowing readers and writers to work with appropriate versions of data instead of unnecessarily blocking each other.


### Two-Phase and Strict Two-Phase Locking
1. Definition ⭐

Two-Phase Locking (2PL) is a concurrency control technique in which a transaction follows two phases: Growing Phase and Shrinking Phase.

Strict Two-Phase Locking (Strict 2PL) is a stronger form of 2PL in which a transaction keeps its exclusive locks until it commits or rolls back.

2. Explanation — What, Why, How ⭐
Two-Phase Locking (2PL)

2PL has two phases:

1. Growing Phase

Transaction can acquire locks.
It cannot release locks.

2. Shrinking Phase

Transaction can release locks.
It cannot acquire new locks.
        Transaction
             |
       Growing Phase
     (Acquire Locks)
             ↓
      Shrinking Phase
      (Release Locks)

The main purpose of 2PL is to ensure conflict-serializable schedules.

Strict Two-Phase Locking

Strict 2PL follows the same basic locking principle, but exclusive (X) locks are held until the transaction commits or rolls back.

Transaction
    ↓
Acquire Locks
    ↓
Read / Write Data
    ↓
COMMIT / ROLLBACK
    ↓
Release Exclusive Locks

This prevents other transactions from reading or modifying data written by an uncommitted transaction.

3. Important Lock Types ⭐
Shared Lock (S)

Used for reading data.

Multiple transactions can usually hold shared locks on the same item.

Exclusive Lock (X)

Used for writing data.

Only one transaction can hold an exclusive lock on a data item at a time.

4. 2PL vs Strict 2PL ⭐
2PL	Strict 2PL
Has growing and shrinking phases	Also follows 2PL
Locks can be released before commit	Exclusive locks are held until commit/rollback
Ensures conflict serializability	Ensures conflict serializability
Can allow cascading rollback	Prevents dirty reads and cascading rollback
Less restrictive	More restrictive but safer
5. Advantages ⭐
2PL
Ensures conflict serializability.
Controls concurrent transactions.
Prevents many concurrency problems.
Strict 2PL
Prevents dirty reads.
Prevents cascading rollback.
Maintains better transaction safety.
Easier crash recovery.
6. Disadvantages ⭐
2PL
Can cause deadlocks.
Lock management adds overhead.
Transactions may have to wait.
Strict 2PL
Transactions may wait longer because locks are held until commit.
Deadlocks are still possible.
Can reduce concurrency in some workloads.
7. Example

Suppose two transactions access the same employee salary.

T1 → Locks salary → Updates salary → Commit → Unlock

T2 → Waits for lock → Reads/updates after T1 releases it

This prevents both transactions from incorrectly modifying the same data at the same time.

Conceptual example — do not run this diagram in MySQL.

8. 10-Mark Exam Answer ⭐⭐⭐

Two-Phase Locking (2PL) is a concurrency control technique used to ensure that concurrent transactions execute safely. It divides a transaction into two phases: Growing Phase and Shrinking Phase.

During the Growing Phase, a transaction can acquire locks but cannot release them. During the Shrinking Phase, the transaction can release locks but cannot acquire new locks. 2PL helps ensure conflict serializability.

Strict Two-Phase Locking (Strict 2PL) is a stricter version of 2PL. In Strict 2PL, exclusive locks are held until the transaction commits or rolls back. This prevents other transactions from accessing uncommitted changes and helps prevent dirty reads and cascading rollback.

The main advantages of 2PL and Strict 2PL are safe concurrent execution, serializability, and better transaction consistency. Their main disadvantage is that they can cause waiting and deadlocks.

Thus, 2PL controls concurrent transactions using locks, while Strict 2PL provides stronger protection by holding exclusive locks until transaction completion.



###  Snapshot Isolation
1. Definition ⭐

Snapshot Isolation is a concurrency control technique in which each transaction reads data from a consistent snapshot of the database taken when the transaction starts.

2. Explanation — What, Why, How ⭐
What is Snapshot Isolation?

Instead of reading the latest changes made by other uncommitted transactions, a transaction works with a snapshot of the database.

Why is it used?

It is used to:

Reduce blocking between readers and writers.
Provide consistent reads.
Allow multiple transactions to execute concurrently.
Improve database performance.
How does it work?

When a transaction starts, it gets a consistent view of the database.

Transaction T1 Starts
        ↓
  Takes Snapshot
        ↓
 Reads from Snapshot
        ↓
Other transactions can
continue updating data

A transaction generally sees data that was committed before its snapshot, according to the database's snapshot rules.

3. Example ⭐

Suppose the employee salary is:

Salary = 60,000

Transaction T1 starts and gets a snapshot.

Then Transaction T2 changes the salary:

T1 Snapshot → ₹60,000
Database    → ₹70,000

T1 can continue reading its consistent snapshot rather than immediately seeing T2's newer value.

Conceptual example — not a SQL command.

4. Snapshot Isolation vs Locking ⭐
Snapshot Isolation	Locking
Reads from a snapshot	Uses locks to control access
Readers usually do not block writers	Readers/writers may wait
Uses multiple versions	Uses locking mechanisms
Provides consistent reads	Controls concurrent access
5. Advantages ⭐
Provides consistent data for a transaction.
Reduces read-write blocking.
Allows better concurrent execution.
Improves performance for read-heavy workloads.
Useful in multi-user database systems.
6. Disadvantages ⭐
Requires maintaining multiple versions of data.
Uses additional storage.
Version management creates overhead.
It does not prevent every type of concurrency anomaly, such as write skew.
7. 10-Mark Exam Answer ⭐⭐⭐

Snapshot Isolation is a concurrency control technique in which each transaction reads data from a consistent snapshot of the database. The snapshot represents the committed state of data according to the transaction's start time.

When a transaction starts, it obtains a snapshot and performs its read operations using that view. Other transactions can continue to update the database without unnecessarily blocking the reader.

For example, if Transaction T1 starts when an employee's salary is ₹60,000 and Transaction T2 later changes it to ₹70,000, T1 may continue to see ₹60,000 through its existing snapshot while T2 works with the newer value.

Snapshot Isolation reduces read-write blocking, provides consistent reads, and improves concurrency. However, it requires additional storage and version management. It can also allow certain anomalies such as write skew.

Therefore, Snapshot Isolation provides a consistent view of data for each transaction while allowing transactions to execute concurrently.


###     Transaction Logging
1. Definition ⭐

Transaction logging is a recovery technique in which the database maintains a log of all important changes made by transactions so that the database can be recovered after a failure.

2. Explanation — What, Why, How ⭐
What is Transaction Logging?

A transaction log records operations performed by transactions, such as:

Transaction start
Data update
Transaction commit
Transaction rollback
Why is it used?

Transaction logging is used to:

Recover data after system failure.
Undo incomplete transactions.
Redo committed transactions if necessary.
Maintain database consistency.
How does it work?

Before or along with changing the database, the system records the change in the log.

Transaction
     ↓
Log Record Created
     ↓
Database Updated
     ↓
COMMIT
     ↓
Transaction Completed
3. Log Record ⭐

A log may contain information such as:

<T1, A, 5000, 7000>

Where:

T1 → Transaction ID
A → Data item
5000 → Old value
7000 → New value

This information can be used during recovery.

4. Important Concepts ⭐
UNDO

Reverses changes made by an incomplete or failed transaction.

REDO

Reapplies changes of a committed transaction if those changes were not completely written to the database before a failure.

Write-Ahead Logging (WAL)

The log record is written to stable storage before the corresponding database change is permanently written.

5. Advantages ⭐
Helps recover the database after failures.
Supports UNDO and REDO operations.
Maintains database consistency.
Helps recover incomplete transactions.
Provides a record of transaction operations.
6. Disadvantages ⭐
Requires additional storage.
Logging creates processing overhead.
Large logs require management and maintenance.
Recovery can take time when the log is very large.
7. Example

Suppose Transaction T1 changes an employee's salary:

Old Salary = ₹60,000
New Salary = ₹70,000

The log may record:

<T1, Salary, 60000, 70000>

If T1 fails before completion, the old value can be used to UNDO the change.

If T1 commits but the database crashes before the change is completely stored, the new value can be used to REDO the change.

Conceptual example — not a SQL command.

8. 10-Mark Exam Answer ⭐⭐⭐

Transaction logging is a database recovery technique in which a log is maintained to record important operations performed by transactions. It helps the database recover from system crashes, transaction failures, and other errors.

A transaction log may contain the transaction ID, data item, old value, new value, and transaction status. For example:

<T1, Salary, 60000, 70000>

The log records the change made by Transaction T1.

Transaction logging mainly supports two recovery operations: UNDO and REDO. UNDO reverses changes made by incomplete transactions, while REDO reapplies changes made by committed transactions when necessary.

Transaction logging commonly follows the Write-Ahead Logging (WAL) principle, in which the log record is stored before the corresponding database modification is permanently written.

The advantages of transaction logging include reliable recovery, database consistency, support for UNDO/REDO operations, and recovery from transaction failures. Its disadvantages include additional storage requirements, processing overhead, and log-management requirements.

Thus, transaction logging is an important part of database recovery because it allows the system to restore the database to a correct state after failures.

9. MySQL Practical — LAST ⭐

MySQL InnoDB automatically maintains transaction and recovery logs internally. We normally do not manually create the internal transaction log using SQL.

You can demonstrate the transaction behavior:

USE company;

START TRANSACTION;

UPDATE employee
SET salary = 70000
WHERE id = 1;

ROLLBACK;

Here:

START TRANSACTION → starts the transaction.
UPDATE → modifies the data.
ROLLBACK → reverses the uncommitted change.


####   Checkpointing
1. Definition ⭐

Checkpointing is a database recovery technique in which the database periodically saves information about the current state of transactions and data to reduce the time required for recovery after a failure.

2. Explanation — What, Why, How ⭐
What is Checkpointing?

A checkpoint is a known recovery point in the transaction log.

Instead of checking the entire log from the beginning after a crash, the recovery system can start from a recent checkpoint.

Why is it used?

Checkpointing is used to:

Reduce recovery time.
Reduce the amount of log that must be processed.
Make crash recovery faster.
Improve database recovery efficiency.
How does it work?
Transaction Log

T1 → T2 → T3 → CHECKPOINT → T4 → T5 → T6
                         ↑
                  Recovery Point

If the system crashes after T6, the recovery process can use the checkpoint as an important starting point instead of processing the complete history.

3. Important Concepts ⭐
Checkpoint Record

A record placed in the log indicating that a checkpoint has occurred.

Active Transactions

Transactions that are still running when the checkpoint is created may need to be considered during recovery.

Recovery Point

The checkpoint provides a known point from which recovery can be performed more efficiently.

4. Advantages ⭐
Reduces recovery time.
Reduces log processing during recovery.
Helps identify a recovery starting point.
Improves database recovery performance.
Useful for large databases with long transaction logs.
5. Disadvantages ⭐
Creating checkpoints requires additional processing.
It may temporarily affect database performance.
Frequent checkpoints can create unnecessary overhead.
Checkpoint management adds complexity.
6. Example

Suppose the transaction log contains:

T1 → T2 → T3 → T4 → CHECKPOINT → T5 → T6

If the database crashes after T6, the recovery process can use the checkpoint to reduce unnecessary log processing.

        CHECKPOINT
             ↓
      Recovery starts
             ↓
          T5 → T6

Conceptual example — not a SQL command.

7. 10-Mark Exam Answer ⭐⭐⭐

Checkpointing is a database recovery technique used to reduce the time required to recover a database after a system failure. A checkpoint periodically records the current state of the database and transaction system in the recovery information.

Without checkpointing, the recovery system may need to examine a large portion of the transaction log. With checkpointing, the recovery process can use the most recent checkpoint as an important recovery point and avoid unnecessary processing of older log records.

For example:

T1 → T2 → T3 → CHECKPOINT → T4 → T5

If a crash occurs after T5, the recovery system can use the checkpoint to reduce the amount of log that needs to be examined.

The main advantages of checkpointing are faster recovery, reduced log processing, and improved recovery efficiency. Its disadvantages include processing overhead and possible temporary performance impact when a checkpoint is created.

Thus, checkpointing is an important recovery technique that makes crash recovery faster and more efficient.

8. MySQL Practical — LAST ⭐

Actual MySQL practical note: MySQL InnoDB performs checkpointing internally as part of its recovery and storage management. You normally do not create a database checkpoint using a simple SQL command.

You can inspect InnoDB engine information with:

SHOW ENGINE INNODB STATUS;

This is an actual MySQL command, but it does not manually create a checkpoint. It allows you to inspect InnoDB's internal status and recovery-related information.

Therefore: Checkpointing is mainly an internal InnoDB recovery mechanism, not a normal SQL operation that we manually execute.

####  ARIES Recovery Algorithm
1. Definition ⭐

ARIES (Algorithms for Recovery and Isolation Exploiting Semantics) is a database recovery algorithm used to recover a database after a system crash or failure.

It uses transaction logs, checkpoints, and the Write-Ahead Logging (WAL) principle to restore the database to a consistent state.

Easy Definition

ARIES is a log-based recovery algorithm that uses analysis, redo, and undo phases to recover a database after a crash.

2. Why is ARIES Needed? ⭐

A database may crash because of:

Power failure
Operating system failure
Hardware failure
Database server crash
Unexpected system shutdown

At the time of failure:

Some transactions may already be committed.
Some transactions may still be incomplete.
Some changes may already be written to disk.
Some changes may exist only in memory.

ARIES determines:

Which transactions were active at the time of crash
Which changes must be REDONE
Which incomplete transactions must be UNDONE
3. Main Idea of ARIES ⭐⭐⭐

ARIES follows three major recovery phases:

              Database Crash
                    │
                    ▼
              ┌─────────────┐
              │   ANALYSIS  │
              └─────────────┘
                    │
                    ▼
              ┌─────────────┐
              │     REDO    │
              └─────────────┘
                    │
                    ▼
              ┌─────────────┐
              │     UNDO    │
              └─────────────┘
                    │
                    ▼
            Database Recovered
Three phases:
Phase	Purpose
Analysis	Determines the state of transactions and database pages at crash
Redo	Repeats necessary changes to reconstruct the database state
Undo	Reverses incomplete transactions
4. How ARIES Works ⭐⭐⭐
Phase 1: Analysis

The Analysis phase starts from the most recent checkpoint and scans the log forward.

It determines:

Which transactions were active when the crash occurred
Which transactions had committed
Which transactions were incomplete
Which database pages may need recovery

ARIES maintains important structures such as:

Transaction Table

Contains information about active transactions.

Example:

Transaction Table

T1 → COMMITTED
T2 → ACTIVE
T3 → ACTIVE
Dirty Page Table

Keeps track of pages that were modified in memory but may not have been written to disk.

Dirty Page Table

Page P1
Page P5
Page P8
Result of Analysis

ARIES identifies:

Winner transactions → transactions that committed
Loser transactions → transactions that were incomplete at crash

Example:

T1 → COMMITTED → Winner
T2 → ACTIVE    → Loser
T3 → ACTIVE    → Loser
5. Phase 2: Redo ⭐⭐⭐

The Redo phase is also called Repeating History.

ARIES starts from the appropriate point in the log and re-applies necessary changes.

The purpose is to reconstruct the database state that existed immediately before the crash.

Example

Suppose the log contains:

<T1, A, 5000 → 6000>
<T2, B, 2000 → 3000>
<T1, COMMIT>

If the database crashed after these operations, ARIES may redo the necessary updates.

REDO
 ↓
A = 6000
B = 3000

Redo does not simply execute every log record blindly. ARIES uses information such as page state and log sequence numbers to determine whether a change needs to be repeated.

6. Phase 3: Undo ⭐⭐⭐

The Undo phase reverses the effects of transactions that were incomplete when the crash occurred.

These transactions are called loser transactions.

Example:

T1 → COMMITTED
T2 → ACTIVE

After the crash:

T1 → Keep changes
T2 → Undo changes

If T2 changed:

Salary: 50000 → 60000

Undo restores:

Salary: 60000 → 50000

ARIES records the undo operations in the log so that recovery remains reliable even if another failure occurs during recovery.

7. Important Concepts in ARIES ⭐
7.1 Write-Ahead Logging (WAL)

ARIES relies heavily on Write-Ahead Logging.

The basic rule is:

The log record describing a change must be written to stable storage before the corresponding modified database page is written to disk.

This ensures that the database has enough information to recover after a crash.

7.2 Log Sequence Number (LSN)

LSN is a unique identifier associated with a log record.

It helps ARIES determine:

The order of log records
Which changes have already been applied
Where recovery should continue

Example:

LSN 100 → Update A
LSN 101 → Update B
LSN 102 → Commit T1
7.3 Checkpoint

ARIES uses checkpoints to reduce the amount of log that must be examined during recovery.

Instead of always scanning the entire log from the beginning, recovery can start from an appropriate checkpoint.

Your previous MySQL output showed:

Last checkpoint at 24026058

and:

Log sequence number 24026058

These are examples of InnoDB's internal log/checkpoint information.

Important: SHOW ENGINE INNODB STATUS displays internal InnoDB status; it does not manually run the ARIES algorithm.

8. ARIES Recovery Example ⭐⭐⭐

Consider this transaction log:

<T1 START>
<T1, A, 100 → 200>
<T2 START>
<T2, B, 300 → 400>
<T1 COMMIT>
--- CRASH ---
Step 1: Analysis

ARIES examines the log.

T1 → COMMITTED
T2 → ACTIVE

Therefore:

T1 → Winner
T2 → Loser
Step 2: Redo

ARIES reconstructs the required database state:

A = 200
B = 400
Step 3: Undo

T2 did not commit, so its change is undone:

B = 300
Final State
A = 200   ← T1 committed
B = 300   ← T2 rolled back

Therefore, the database returns to a consistent recoverable state.

9. ARIES Recovery Flow ⭐⭐⭐
                 SYSTEM CRASH
                      │
                      ▼
              Latest Checkpoint
                      │
                      ▼
              ┌──────────────┐
              │   ANALYSIS   │
              │              │
              │ Find active  │
              │ transactions │
              │ and dirty    │
              │ pages        │
              └──────┬───────┘
                     │
                     ▼
              ┌──────────────┐
              │     REDO     │
              │              │
              │ Repeat       │
              │ necessary    │
              │ history      │
              └──────┬───────┘
                     │
                     ▼
              ┌──────────────┐
              │     UNDO     │
              │              │
              │ Reverse loser │
              │ transactions │
              └──────┬───────┘
                     │
                     ▼
             DATABASE RECOVERED
10. Advantages of ARIES ⭐
Reliable crash recovery
Uses Write-Ahead Logging
Supports REDO and UNDO
Uses checkpoints to reduce recovery work
Handles transactions that were active during a crash
Supports efficient recovery of large databases
Can recover from failures without losing committed changes
Maintains database consistency after crashes
11. Disadvantages of ARIES ⭐
Complex implementation
Requires management of log records and LSNs
Logging creates storage overhead
Recovery can take time for large logs
Requires careful management of checkpoints
Recovery logic is more complicated than simple undo/redo techniques
12. ARIES vs Simple Log-Based Recovery
Feature	Simple Log Recovery	ARIES
Logging	Yes	Yes
REDO	Yes	Yes
UNDO	Yes	Yes
Checkpoints	May be used	Important
LSN	Usually not central	Important
Analysis phase	Usually not	Yes
Recovery complexity	Lower	Higher
Used in advanced DBMS recovery	Basic concept	Major recovery approach
13. 10-Mark Exam Answer ⭐⭐⭐
ARIES Recovery Algorithm

ARIES (Algorithms for Recovery and Isolation Exploiting Semantics) is a log-based database recovery algorithm designed to recover a database after system failures. It uses Write-Ahead Logging, checkpoints, Log Sequence Numbers, and three recovery phases: Analysis, Redo, and Undo.

Working of ARIES

1. Analysis Phase:
ARIES starts from the appropriate checkpoint and scans the log forward. It identifies active transactions and dirty database pages. Transactions that committed are considered winner transactions, while incomplete transactions are considered loser transactions.

2. Redo Phase:
ARIES redoes necessary changes from the log. This phase is known as repeating history because it reconstructs the database state that existed immediately before the crash.

3. Undo Phase:
ARIES reverses the changes made by loser transactions. The changes of incomplete transactions are undone so that the database returns to a consistent state.

Important Components
Write-Ahead Logging (WAL): Log records are written before corresponding database pages.
LSN: Identifies and orders log records.
Checkpoint: Reduces the amount of log that must be processed during recovery.
Transaction Table: Tracks transaction status.
Dirty Page Table: Tracks modified pages that may not have been written to disk.
Flow
Crash
  ↓
Analysis
  ↓
Redo
  ↓
Undo
  ↓
Recovered Database
Advantages
Reliable crash recovery
Preserves committed changes
Supports REDO and UNDO
Uses checkpoints for efficient recovery
Handles incomplete transactions
Maintains database consistency
Conclusion

ARIES is an important recovery technique for modern database systems because it efficiently reconstructs database state after failures using logging, checkpoints, REDO, and UNDO operations.

14. MySQL Practical — LAST ⭐
Important

ARIES itself is not something you manually execute using a MySQL command. It is a recovery algorithm implemented internally by database systems.

MySQL's InnoDB uses advanced log-based crash-recovery mechanisms involving redo logs, undo information, checkpoints, and related recovery structures.

You can demonstrate the transaction behavior behind recovery with:

USE company;

START TRANSACTION;

UPDATE employee
SET salary = 70000
WHERE id = 1;

SELECT * FROM employee
WHERE id = 1;

ROLLBACK;

Then verify:

SELECT * FROM employee
WHERE id = 1;

The update is rolled back.

For internal InnoDB status:

SHOW ENGINE INNODB STATUS;

Your previous output showed the InnoDB LOG section, including the Log Sequence Number and Last checkpoint information.

This practical demonstrates transaction/recovery behavior, not a manual execution of the ARIES algorithm.



#### Crash Recovery and Log-Based Recovery Techniques
1. Definition ⭐

Crash Recovery is the process of restoring a database to a consistent and correct state after a system failure or crash.

Log-Based Recovery is a recovery technique in which the database maintains a log of transaction operations and uses that log to recover committed and incomplete transactions after a failure.

Easy Definition

Crash recovery restores the database after a failure, while log-based recovery uses transaction logs to perform that recovery.

2. Why Crash Recovery is Needed ⭐

A database system may fail because of:

Power failure
Operating system crash
Hardware failure
Database server failure
Unexpected shutdown
Software errors

A crash can occur while transactions are still executing.

For example:

T1 → UPDATE employee
T1 → UPDATE employee
T1 → COMMIT

If the system crashes before COMMIT, the transaction may be incomplete.

The recovery system must determine:

Which transactions were completed?
Which transactions were incomplete?
Which changes should remain?
Which changes should be reversed?
3. Basic Crash Recovery Process ⭐⭐⭐
             SYSTEM CRASH
                  │
                  ▼
          Examine Transaction Log
                  │
          ┌───────┴────────┐
          ▼                ▼
   Committed             Uncommitted
   Transactions          Transactions
          │                │
          ▼                ▼
         REDO             UNDO
          │                │
          └───────┬────────┘
                  ▼
        Consistent Database
Committed Transaction

Changes of a committed transaction must be preserved.

Uncommitted Transaction

Changes of an incomplete transaction must be reversed.

4. Log-Based Recovery ⭐⭐⭐

A transaction log is a record of important operations performed by transactions.

A simplified log may look like:

<T1 START>
<T1, A, 5000, 6000>
<T1 COMMIT>

<T2 START>
<T2, B, 3000, 4000>
--- CRASH ---

Here:

T1 committed → preserve its changes.
T2 did not commit → undo its changes.
5. Important Information in a Log

A transaction log may contain records such as:

Start
<T1 START>

Indicates that transaction T1 has started.

Update
<T1, A, 5000, 6000>

Means:

Transaction: T1
Data item: A
Old value: 5000
New value: 6000
Commit
<T1 COMMIT>

Indicates that T1 successfully completed.

Rollback/Abort
<T1 ABORT>

Indicates that the transaction was aborted.

6. Write-Ahead Logging (WAL) ⭐⭐⭐

Write-Ahead Logging is an important principle used in log-based recovery.

Rule

The log record describing a database modification must be stored safely before the corresponding modified database page is written to disk.

Example:

Transaction
     │
     ▼
Create Log Record
     │
     ▼
Write Log to Stable Storage
     │
     ▼
Write Database Page
Why?

If the system crashes after the database page is modified, the log still contains information needed for recovery.

7. Main Log-Based Recovery Techniques ⭐⭐⭐

The major techniques are:

Deferred Update
Immediate Update
8. Deferred Update ⭐

In Deferred Update, changes made by a transaction are not written to the database permanently until the transaction commits.

Working
Transaction
     ↓
Changes kept temporarily
     ↓
COMMIT
     ↓
Changes written to database

If the transaction crashes before committing:

No permanent database changes
        ↓
No UNDO required

After a crash, committed transactions may need to be REDONE.

Example
<T1 START>
<T1, A, 5000 → 6000>
<T1 COMMIT>

If T1 committed but its updated value was not yet written to disk, recovery can redo the change.

Advantages
Simpler recovery
No UNDO for uncommitted transactions
Maintains database consistency
Disadvantages
May require REDO operations
Changes may be delayed
Requires temporary storage/buffering
9. Immediate Update ⭐

In Immediate Update, changes can be written to the database before the transaction commits.

Therefore, both UNDO and REDO may be required.

Working
Transaction
     ↓
Change Database
     ↓
Write Log
     ↓
COMMIT

If the transaction crashes before committing:

UNDO changes

If a committed change was not reflected on disk:

REDO changes
Example
<T1 START>
<T1, A, 5000 → 6000>
--- CRASH ---

Since T1 did not commit:

UNDO
A = 6000 → 5000
10. Deferred vs Immediate Update ⭐⭐⭐
Feature	Deferred Update	Immediate Update
Database update	After commit	Can occur before commit
UNDO	Usually not required	Required
REDO	May be required	May be required
Recovery	Simpler	More complex
Uncommitted changes on disk	No	Possible
Log usage	Required	Required
Easy Memory Trick
Deferred  → Delay database update
Immediate → Update can happen immediately
11. UNDO and REDO ⭐⭐⭐
UNDO

UNDO reverses the changes of an incomplete or failed transaction.

Example:

Before: 50000
Update: 60000
Crash before COMMIT
       ↓
UNDO
       ↓
50000
REDO

REDO reapplies changes of a committed transaction when necessary.

Example:

Before: 50000
Update: 60000
COMMIT
Crash before change reaches disk
       ↓
REDO
       ↓
60000
12. Combined UNDO/REDO Recovery ⭐

Modern recovery systems can use both operations.

             Crash
               │
               ▼
         Examine Log
               │
        ┌──────┴──────┐
        ▼             ▼
    Committed      Uncommitted
        │             │
        ▼             ▼
       REDO           UNDO
        │             │
        └──────┬──────┘
               ▼
       Consistent Database

This is the basic idea behind advanced recovery systems such as ARIES.

13. Example of Crash Recovery ⭐⭐⭐

Suppose the log is:

<T1 START>
<T1, A, 1000 → 1500>
<T1 COMMIT>

<T2 START>
<T2, B, 2000 → 2500>

--- SYSTEM CRASH ---
Recovery Analysis

T1:

T1 → COMMITTED

Therefore:

REDO T1 if necessary

T2:

T2 → NOT COMMITTED

Therefore:

UNDO T2
Final Result
A = 1500
B = 2000

T1's committed change remains, while T2's incomplete change is removed.

14. Advantages of Log-Based Recovery ⭐
Helps recover from system crashes.
Preserves committed transactions.
Removes incomplete transaction effects.
Supports UNDO and REDO.
Helps maintain database consistency.
Works with checkpoints to reduce recovery time.
Provides a reliable record of transaction operations.
15. Disadvantages ⭐
Logs require additional storage.
Maintaining logs creates overhead.
Large logs can increase recovery time.
Log management can be complex.
Recovery algorithms require careful implementation.
16. 10-Mark Exam Answer ⭐⭐⭐
Crash Recovery and Log-Based Recovery Techniques

Crash recovery is the process of restoring a database to a consistent state after a system failure. Failures may occur due to power failure, hardware problems, operating system crashes, or database server failures.

Log-based recovery maintains a transaction log containing important transaction operations such as start, update, commit, and abort records. After a crash, the log is examined to determine which transactions must be preserved and which must be reversed.

The two major log-based recovery techniques are deferred update and immediate update.

In deferred update, changes are not permanently written to the database until the transaction commits. Therefore, uncommitted transactions generally do not require UNDO, while committed transactions may require REDO.

In immediate update, database changes may be written before the transaction commits. Therefore, recovery may require both UNDO and REDO operations.

UNDO reverses the changes of incomplete transactions, while REDO reapplies the changes of committed transactions when required.

The Write-Ahead Logging (WAL) principle ensures that the log record is safely written before the corresponding database page is written to disk.

Recovery Flow
System Crash
     ↓
Examine Log
     ↓
Identify Transactions
     ↓
Committed → REDO
Uncommitted → UNDO
     ↓
Consistent Database

Thus, log-based recovery is an important technique for protecting database consistency and recovering transaction states after failures.