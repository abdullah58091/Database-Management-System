# Unit 2 - ER Modeling

## Entity

An entity is a real-world object about which data is stored in a database.

Examples:
- Student
- Teacher
- Course

## Attribute

An attribute is a property or characteristic of an entity.

Examples:
- Student_ID
- Name
- Age

## Relationship

A relationship represents an association between two or more entities.

Example:
Student ----- Enrolls ----- Course

## ER Diagram

Student
├── Student_ID
├── Name
├── Age

Course
├── Course_ID
├── Course_Name

Student ----- Enrolls ----- Course

## Relational Schema

Student(Student_ID, Name, Age)

Course(Course_ID, Course_Name)

Definition:
Relational Schema is the logical structure of a database table that defines its attributes and relationships.