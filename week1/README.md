# Week 1 - Campus Equipment Lending Desk
Dr. Heather Wegwerth 
Jeffrey Yabandith
CST 335 100 Data Management & Big Data Systems

The campus equipment lending desk lends out laptops, cameras, microphones, and projectors to students for short periods. Currently now, the staff track it all on paper manually, and they want a database that can tell them who has which item, which items are out vs. available, and how often a student has borrowed an item.
I used three tables. Student and Item are the two main things that are being tracked, and they exist on their own. Basically that means that a student is still a student whether or not they have borrowed anything, and an item is still an item whether or not it is checked out. Loan is the item that sits between them and records one checkout at a time. I needed that third table because one student can borrow many items and one item can be borrowed by many students, so the two tables cannot be connected directly due to the different relationships. The other choice I made was to leave ActualReturnDate empty until the item comes back. That way an empty value means the item is still out, and the staff do not have to remember to manually fix this when something gets returned.
# Tables
Student - primary key StudentID. This holds the student's first name, last name, and email. The email is marked UNIQUE so two students cannot be entered with the same address.
Item - primary key ItemID. Holds the item name, its category (laptop, camera, etc.), and its current status (this involves available, checked_out, and maintenance).
Loan - primary key LoanID. Holds which student borrowed which item, the checkout date, the expected return date, and the actual return date. The actual return date is the only column allowed to be empty, since it is not known yet when the item goes out.
Every other column is NOT NULL, because a loan with no borrower or no checkout date makes no sense.
# How the tables are related
-- Loan.StudentID references Student.StudentID
-- Loan.ItemID references Item.ItemID
A student can have many loans, and an item can have many loans over time, but each loan belongs to exactly one student and one item. Student and Item are never joined to each other directly. Loan is what is connecting them.
# Sample data
-- 3 students
-- 5 items across four categories
-- 6 loans, two of which are still open and one that was returned late
# Running the scripts
From the project folder:
```
sqlite3 lending.db < week1_schema.sql
sqlite3 lending.db < week1_data.sql
sqlite3 lending.db < week1_queries.sql
```
Or open SQLite first and read the files in:
```
sqlite3 lending.db
```

.read week1_schema.sql
.read week1_data.sql
.read week1_queries.sql

# AI assistance
After trying to run my scripts in SQLite to check my work and so that my queries would return as they shoukd, I had tried to put in some bad data to see what would happen. I happened to do a loan that was out to a student ID that did not exist and a row in student that was missing a name. I wanted to make sure that the table would actually work as intended and not run with an error. I ran into an error with my foreign keys and after consulting Claude to check my work, turns out my foreign keys were not doing anything, especially since the setting is based on per connection instead of per database, making me have to start with it in every script. That is why there is a 'PRAGMA foreign_keys = ON;' at the top of each script. 