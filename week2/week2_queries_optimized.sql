-- Week 2 Assignment - Equipment Lending Desk Performance
-- week2_queries_optimized.sql
-- Dr. Heather Wegwerth
-- CST 335 100 Data Management & Big Data Systems
-- Jeffrey Yabandith
-- the same three questions as the baseline file but rewritten. two things are
-- changed: I picked the columns I actually needed instead of using SELECT *,
-- and now the filters are sitting on columns that have an index.
-- run this after week2_indexes.sql.

PRAGMA foreign_keys = ON;

.headers on
.mode column
.timer on
-- optimized 1: the activity report, but only the six columns that are needed get
-- printed, and only the ones for this semester instead of all 120 loans that are going back
-- to last September. This is taking it from 120 rows down to 18.
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
WHERE l.CheckoutDate >= '2026-08-24';


-- optimized 2: one student's loans(103). Same filter as the baseline, but
-- now idx_loan_student is in play, so SQLite goes straight will go straight to that
-- student's rows instead of reading the whole table.
SELECT
    l.LoanID,
    i.ItemName,
    l.CheckoutDate,
    l.ExpectedReturnDate,
    l.ActualReturnDate
FROM Loan AS l
JOIN Item AS i ON l.ItemID = i.ItemID
WHERE l.StudentID = 103;
-- optimized 3: what is being checked out right now.
-- idx_loan_return lets SQLite find the rows with no return date
-- instead of reading all 120 and discarding the 117 that came back.
SELECT
    i.ItemName,
    i.Category,
    s.FirstName,
    s.LastName,
    l.CheckoutDate,
    l.ExpectedReturnDate
FROM Loan AS l
JOIN Item    AS i ON l.ItemID = i.ItemID
JOIN Student AS s ON l.StudentID = s.StudentID
WHERE l.ActualReturnDate IS NULL;


-- query plan for optimized 2, to run and compare against the baseline query plan.
EXPLAIN QUERY PLAN
SELECT
    l.LoanID,
    i.ItemName,
    l.CheckoutDate,
    l.ExpectedReturnDate,
    l.ActualReturnDate
FROM Loan AS l
JOIN Item AS i ON l.ItemID = i.ItemID
WHERE l.StudentID = 103;
