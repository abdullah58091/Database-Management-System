Database Security (Unit 4)



## Deadlock Detection & Prevention
## Authentication
## Authorization
## RBAC
## Data Encryption
## Data Integrity
Database Security Best Practices
1. Deadlock
Professional Definition (English)

A deadlock is a situation in which two or more transactions are permanently blocked because each transaction is waiting for a resource that is held by another transaction.

Hinglish Explanation

Socho do log hain.

Rahul ke paas Bike hai.

Ali ke paas Car hai.

Rahul bolta hai

"Pehle Car do."

Ali bolta hai

"Pehle Bike do."

Dono wait kar rahe hain.

Koi bhi resource release nahi kar raha.

System freeze.

Ye hi Deadlock hai.

Database Example

Transaction T1

Lock(A)

Waiting for Lock(B)

Transaction T2

Lock(B)

Waiting for Lock(A)

Result

T1 → waiting for B

T2 → waiting for A

Infinite Wait

Deadlock.

Real Company Example

Imagine

Bank Database

Transaction 1

Updating Account A

Needs Account B

Transaction 2

Updating Account B

Needs Account A

Dono wait.

Money transfer stop.

Customers affected.

Why Deadlock is Bad?
Transactions never finish
Database slows down
Resources remain locked
Users wait forever
Server performance decreases
Deadlock Detection
Definition

Deadlock detection is the process of identifying deadlocks after they occur and taking corrective actions to resolve them.

Simple language

Pehle deadlock hone do.

Fir database detect karega.

Fir ek transaction ko kill karega.

Wait-for Graph

Sabse famous method.

Example

T1 → T2

T2 → T3

T3 → T1

Circle mil gaya.

Deadlock.

Rule

Cycle Present

↓

Deadlock Present

No Cycle

↓

No Deadlock

Deadlock Prevention

Definition

Deadlock prevention ensures that the system never enters a deadlock state by restricting resource allocation.

Matlab

Deadlock hone hi mat do.

Methods
1. Resource Ordering

Sab transactions same order follow kare.

Example

Always

Lock A

Then Lock B

Never

B then A

Deadlock impossible.

2. Timeout

Transaction bahut der tak wait kare?

Cancel.

Example

Wait > 30 sec

Abort Transaction
3. Rollback

Ek transaction ko undo kar do.

Dusra continue karega.

4. Wound-Wait

Old transaction

↓

Kills young transaction.

5. Wait-Die

Old transaction

↓

Can Wait

Young transaction

↓

Dies (Rollback)

Ye advanced algorithms hain jo DBMS concurrency control mein use hote hain.

Detection vs Prevention
Detection	Prevention
Deadlock hone deta hai	Hone hi nahi deta
Wait-for Graph	Resource Ordering
Abort later	Prevent earlier
Better resource utilization	More restrictions
Slightly complex	Simpler concept
Interview Question

Difference?

Detection

Deadlock occurs first.

Then detected.

Prevention

Deadlock never allowed.

Authentication
Professional Definition

Authentication is the process of verifying the identity of a user before granting access to a database system.

Hinglish

Database puchta hai

"Tum kaun ho?"

User

"Main Abdullah"

Database

"Proof?"

Password

Fingerprint

OTP

Face

Certificate

Jo proof sahi

↓

Authentication successful

Example
Username

Password

Login Success

Authentication Methods
Password

Most common.

OTP

One Time Password

Fingerprint

Biometric Authentication

Face Recognition
Multi Factor Authentication (MFA)

Password

OTP

Fingerprint

More secure.

Authorization

Professional Definition

Authorization is the process of determining what resources and operations an authenticated user is permitted to access.

Authentication

↓

Who are you?

Authorization

↓

What are you allowed to do?

Example

Student Login

Can

Read Marks

Cannot

Delete Database

Teacher

Can

Update Marks

Admin

Can

Delete Records

Authentication vs Authorization
Authentication	Authorization
Verify Identity	Verify Permission
Login	Access Control
Username Password	Roles & Permissions
Happens First	Happens After

Remember

Authentication

↓

Identity

Authorization

↓

Permission

## RBAC

Role Based Access Control

Professional Definition

Role-Based Access Control (RBAC) is a security model in which permissions are assigned to roles instead of individual users.

Hinglish

Har user ko permission mat do.

Role banao.

Fir role assign karo.

Example

Admin

Read

Write

Delete

Update

Teacher

Read

Write

Update

Student

Read Only

Simple.

Advantages

Easy Management

High Security

Less Errors

Scalable

Used Everywhere

Real Companies

Google

Microsoft

Amazon

Oracle

Banks

Hospitals

All use RBAC.

Data Encryption

Professional Definition

Data encryption is the process of converting readable data into an unreadable format using cryptographic algorithms to protect it from unauthorized access.

Simple

Original Data

↓

Encryption

↓

Cipher Text

↓

Only key holder

↓

Decrypt

↓

Original Data

Example

Original

Password123

Encrypted

A8x#P91@Lm

Hacker dekhega

Nothing understandable.

Types
At Rest

Stored Database

Encrypted.

Example

Hard Disk

SSD

Cloud Storage

In Transit

Internet

Encryption.

Example

Client

↓

HTTPS

↓

Database Server

Benefits

Confidentiality

Privacy

Compliance

Protection

Secure Storage

Data Integrity

Professional Definition

Data integrity is the assurance that data remains accurate, consistent, complete, and unaltered throughout its lifecycle.

Simple

Data

Wrong nahi hona chahiye.

Missing nahi hona chahiye.

Duplicate nahi hona chahiye.

Accurate hona chahiye.

Example

Student Marks

Original

95

Hacker

10

Integrity Broken.

Types

Entity Integrity

Primary Key unique.

Referential Integrity

Foreign Key valid.

Domain Integrity

Correct Data Type.

User Defined Integrity

Business Rules.

Example

Salary

Cannot be Negative.

 ## Database Security Best Practices

Professional Definition

Database security best practices are recommended techniques and policies used to protect databases from unauthorized access, data breaches, and cyber attacks.

Important Practices
Strong Passwords

Long

Complex

Unique

Multi-Factor Authentication

Password

OTP

Least Privilege Principle

User ko sirf utni permission do jitni zarurat hai.

Encryption

Data At Rest

Data In Transit

Regular Backups

Recovery after failure.

Patch Updates

Database software updated rakho.

Audit Logs

Har activity record karo.

Example

Who Logged In

Who Deleted Data

Who Updated Salary
Firewall

Database ko internet se directly expose mat karo.

SQL Injection Protection

Always use

Prepared Statements

Parameterized Queries

Access Control

RBAC

Least Privilege

Monitoring

Suspicious activity detect karo.

Real-World Security Flow
User
   │
   ▼
Authentication
(Who are you?)
   │
   ▼
Authorization
(What can you do?)
   │
   ▼
RBAC
(Role decides permissions)
   │
   ▼
Encryption
(Protect stored/transmitted data)
   │
   ▼
Integrity Checks
(Data stays accurate)
   │
   ▼
Best Practices
(Backups, logs, updates, monitoring) 