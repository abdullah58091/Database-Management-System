### UNIT 2 — DISTRIBUTED AND PARALLEL DATABASES
Topic 1: Architecture of Distributed Databases
1. Definition

A distributed database is a collection of logically related data that is stored at multiple geographically or physically separated locations and managed by a distributed database management system (DDBMS).

2. What is Distributed Database Architecture?

Distributed database architecture describes how data, database servers, users, applications, and communication networks are organized and connected in a distributed database system.

In a distributed database system, data is stored at multiple sites instead of being stored at a single centralized location. A Distributed Database Management System (DDBMS) coordinates these sites and provides users with a unified view of the database.

3. Why is a Distributed Database Used?

Distributed databases are used when an organization has data and users located at different geographical locations.

For example, a multinational company may have:

             Company Database
                    |
       -----------------------------
       |             |             |
    Delhi         Mumbai        Bangalore
     Site           Site           Site

Each site can store and process local data while communicating with other sites when required.

4. Basic Architecture
              Users / Applications
                       |
                       ↓
                    DDBMS
                       |
             Communication Network
              /         |         \
             /          |          \
            ↓           ↓           ↓
         Site 1       Site 2      Site 3
        Database     Database    Database
5. Main Components

1. Users and Applications

Users access the distributed database through applications or SQL queries.

2. Distributed DBMS (DDBMS)

The DDBMS manages and coordinates databases located at different sites.

It performs tasks such as:

Query processing
Query optimization
Transaction management
Concurrency control
Data location management
Recovery

3. Database Sites

A site is a physical location containing a database server or database system.

4. Communication Network

The network allows different database sites to communicate and exchange data.

6. Types of Distributed Database Architecture
A. Client-Server Architecture

In client-server architecture, the client sends requests to a database server, and the server processes the requests.

Client
   |
   ↓
Database Server
   |
   ↓
Database

Example: A Java/Spring Boot application sends an SQL query to a MySQL database server.

B. Peer-to-Peer Architecture

In peer-to-peer architecture, multiple database sites can communicate directly and may perform similar database functions.

        Site A
       /      \
      /        \
   Site B ---- Site C

This architecture is useful when multiple sites need to cooperate without depending on a single central database server.

7. Advantages
1. Improved Availability

Data and services can remain available even if one site becomes unavailable, depending on the system design.

2. Better Performance

Users can access data from a nearby site, which can reduce communication delay.

3. Scalability

New database sites can be added as the organization grows.

4. Fault Tolerance

Failures can potentially be isolated to individual sites instead of affecting the entire system.

5. Local Data Management

Individual sites can manage their local data while still participating in the distributed system.

8. Disadvantages
1. High Complexity

Managing multiple database sites is more complex than managing a centralized database.

2. Network Dependency

Communication between sites depends on a reliable network.

3. Data Consistency Problems

Maintaining consistent data across multiple sites can be challenging, especially when data is replicated.

4. Security Challenges

Security policies, authentication, and access control must be managed across multiple locations.

5. Higher Maintenance Cost

Monitoring, backup, recovery, synchronization, and administration can become more difficult.

9. Real-World Example

Consider a banking organization with branches in Delhi, Mumbai, and Bangalore.

              Banking System
                    |
        -------------------------
        |           |           |
      Delhi       Mumbai     Bangalore
       DB           DB          DB

Each branch can manage its local transactions while the distributed database system allows information to be shared between branches.

10. Practical Example

In a distributed environment, an application may need to retrieve customer information from one database site and transaction information from another site.

Conceptually:

SELECT customer_name, transaction_amount
FROM Customer
JOIN Transaction
ON Customer.customer_id = Transaction.customer_id;

The DDBMS is responsible for determining where the required data is located and how the query should be executed efficiently across the distributed sites.

11. Centralized vs Distributed Database
Centralized Database	Distributed Database
Data is mainly stored at one location.	Data is stored at multiple locations.
Easier to manage.	More complex to manage.
Failure of the central system can affect the whole system.	Failures can potentially be isolated to individual sites.
Limited geographical distribution.	Suitable for geographically distributed organizations.
Communication is simpler.	Communication between sites is required.
Scaling can create a central bottleneck.	Workload can be distributed among multiple sites.
12. Exam-Ready Answer

If the exam asks:

"Explain the architecture of distributed databases."

You can write:

Distributed database architecture refers to the organization of data, database sites, users, applications, communication networks, and the Distributed Database Management System (DDBMS) in a distributed database environment. In a distributed database, logically related data is stored at multiple physically separated locations. The DDBMS coordinates these sites and provides users with a unified view of the database.

The major components of distributed database architecture are users or applications, the DDBMS, database sites, and the communication network. The common architectures include client-server and peer-to-peer architectures. Distributed databases provide advantages such as improved availability, scalability, better local performance, and fault tolerance. However, they also introduce challenges such as network dependency, data consistency, security, complexity, and maintenance costs.

Ye answer tum directly paper mein use kar sakte ho.

Quick Revision
Distributed Database
        ↓
Data stored at multiple sites
        ↓
DDBMS coordinates sites
        ↓
Network connects sites
        ↓
Advantages → Availability, Scalability, Performance
        ↓
Challenges → Complexity, Network, Consistency, Security


###  Unit 2 — Data Fragmentation and Replication
1. Definition ⭐
Data Fragmentation

Data fragmentation is the process of dividing a database relation into smaller logical parts called fragments and storing them at different sites in a distributed database system.

Data Replication

Data replication is the process of maintaining copies of the same data at multiple sites in a distributed database system.

2. Why are Fragmentation and Replication Used? ⭐

They are used to improve:

Data access performance
Availability
Reliability
Scalability
Local data access
Fault tolerance
3. Types of Data Fragmentation ⭐

There are three main types.

A. Horizontal Fragmentation

A table is divided row-wise.

Example:

Employee
----------------
ID | Name | Dept
1  | Ali  | IT
2  | John | HR
3  | Sara | IT
4  | David| Finance

It can be divided as:

Site 1 → IT employees
Site 2 → HR employees
Site 3 → Finance employees

The columns remain the same, but different rows are stored at different sites.

Easy memory:
Horizontal = Rows

B. Vertical Fragmentation

A table is divided column-wise.

Example:

Employee
----------------------------
ID | Name | Department | Salary

It can be divided into:

Fragment 1
ID | Name | Department

Fragment 2
ID | Salary

The primary key is generally included in fragments so that the original relation can be reconstructed.

Easy memory:
Vertical = Columns

C. Hybrid Fragmentation

Hybrid fragmentation combines horizontal and vertical fragmentation.

Example:

Employee
   ↓
Horizontal Fragmentation
   ↓
IT Employees
   ↓
Vertical Fragmentation
   ↓
ID | Name | Salary

Easy memory:
Hybrid = Horizontal + Vertical

4. Data Replication ⭐

Replication means maintaining copies of data at multiple sites.

Example:

             Employee Data
                  |
       -----------------------
       ↓          ↓          ↓
    Delhi      Mumbai     Bangalore
      Copy       Copy        Copy

If the same data is available at multiple locations, users can access a nearby copy.

Types of Replication

1. Full Replication

The complete database or relation is copied to multiple sites.

2. Partial Replication

Only selected data is replicated at selected sites.

5. Advantages ⭐
Fragmentation
Reduces the amount of data accessed at each site.
Improves local query performance.
Reduces unnecessary network communication.
Supports efficient data distribution.
Replication
Improves data availability.
Provides better read performance.
Improves fault tolerance.
Allows users to access a nearby copy of data.
6. Disadvantages ⭐
Fragmentation
Fragment management becomes complex.
Queries may require data from multiple sites.
Reconstruction of the original relation can require additional processing.
Replication
Requires additional storage.
Data consistency becomes difficult.
Updates must be propagated to multiple copies.
Maintaining replicas increases system complexity.
7. Fragmentation vs Replication ⭐
Fragmentation	Replication
Divides data into smaller fragments.	Creates copies of data.
Different sites store different portions.	Multiple sites store the same data.
Mainly improves local data access.	Mainly improves availability and access.
Reduces amount of data stored at each site.	Increases storage requirements.
Consistency is comparatively simpler.	Maintaining consistency can be challenging.
Remember:

Fragmentation = Divide the data
Replication = Copy the data

8. 10-Mark Exam Answer ⭐⭐⭐

Data fragmentation and replication are important techniques used in distributed databases to distribute and manage data across multiple sites.

Data fragmentation is the process of dividing a database relation into smaller logical parts called fragments and storing them at different sites. Fragmentation can be classified into horizontal, vertical, and hybrid fragmentation. Horizontal fragmentation divides a relation based on rows, vertical fragmentation divides it based on columns, and hybrid fragmentation combines both techniques.

Data replication is the process of maintaining copies of the same data at multiple sites. Replication can be full or partial depending on whether the complete or selected data is copied.

Fragmentation improves local query performance and reduces unnecessary data transfer. Replication improves availability, read performance, and fault tolerance. However, fragmentation increases management complexity, while replication requires additional storage and creates data consistency challenges.

Therefore, fragmentation and replication are important for achieving efficient, available, and scalable distributed database systems.

9. MySQL Practical — LAST ⭐

Bhai, important point: MySQL mein hum distributed database fragmentation/replication ko genuinely demonstrate nahi kar sakte using your current single company database, because distributed databases require multiple database sites/nodes.

Lekin fragmentation ka concept tumhare existing table se demonstrate kar sakte ho.

Horizontal Fragmentation — practical concept
SELECT *
FROM employee
WHERE department = 'IT';

Ye sirf IT employees ki rows retrieve karta hai.

Vertical Fragmentation — practical concept
SELECT id, name, salary
FROM employee;

Ye sirf selected columns retrieve karta hai.

Note: Ye queries actual distributed fragmentation create nahi karti; ye sirf fragmentation ka concept practically demonstrate karti hain.

Final memory trick 🧠
Fragmentation → Divide
Replication   → Copy

Horizontal → Rows
Vertical   → Columns
Hybrid     → Both