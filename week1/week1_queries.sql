-- Week 1 Assignment - Campus Equipment Lending Desk
-- week1_queries.sql
-- Dr. Heather Wegwerth
-- CST 335 100 Data Mangament & Big Data Systems
-- Jeffrey Yabandith
PRAGMA foreign_keys = ON;
.headers on
.mode column
SELECT
    StudentID,
    FirstName,
    LastName,
    Email
FROM Student;
SELECT
    ItemID,
    ItemName,
    Category,
    Status
FROM Item;
SELECT
    l.LoanID,
    s.FirstName,
    s.LastName,
    i.ItemName,
    l.CheckoutDate,
    l.ExpectedReturnDate
FROM Loan AS l
JOIN Student AS s ON l.StudentID = s.StudentID
JOIN Item    AS i ON l.ItemID = i.ItemID
ORDER BY l.CheckoutDate;
SELECT
    s.FirstName,
    s.LastName,
    i.ItemName,
    l.CheckoutDate,
    l.ActualReturnDate
FROM Loan AS l
JOIN Student AS s ON l.StudentID = s.StudentID
JOIN Item    AS i ON l.ItemID = i.ItemID
WHERE s.StudentID = 101
ORDER BY l.CheckoutDate;
SELECT
    i.ItemID,
    i.ItemName,
    s.FirstName,
    s.LastName,
    l.CheckoutDate,
    l.ExpectedReturnDate
FROM Loan AS l
JOIN Item    AS i ON l.ItemID = i.ItemID
JOIN Student AS s ON l.StudentID = s.StudentID
WHERE l.ActualReturnDate IS NULL
ORDER BY l.ExpectedReturnDate;
