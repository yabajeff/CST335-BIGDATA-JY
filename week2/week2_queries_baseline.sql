-- Week 2 Assignment - Equipment Lending Desk Performance
-- week2_queries_baseline.sql
-- Dr. Heather Wegwerth
-- CST 335 100 Data Management & Big Data Systems
-- Jeffrey Yabandith
-- these are the three baseline queries
PRAGMA foreign_keys = ON;
.headers on
.mode column
.timer on
-- problem: SELECT * pulls from every column from all of the three tables, and there
-- is no WHERE, so it will return all 120 of the loans going back in time a full year.
SELECT *
FROM Loan AS l
JOIN Student AS s ON l.StudentID = s.StudentID
JOIN Item    AS i ON l.ItemID = i.ItemID;
-- problem: there is no index on Loan.StudentID, so SQLite will have to check
-- all 120 rows to find the 13 that is belonging to student 103.
SELECT *
FROM Loan
WHERE StudentID = 103;
-- problem: same thing. nothing is helping SQLite find the open loans, so it will again
-- read all 120 rows and throw away the ones that were returned.
SELECT *
FROM Loan AS l
JOIN Student AS s ON l.StudentID = s.StudentID
JOIN Item    AS i ON l.ItemID = i.ItemID
WHERE l.ActualReturnDate IS NULL;
-- query plan for baseline 2.
EXPLAIN QUERY PLAN
SELECT *
FROM Loan
WHERE StudentID = 103;
