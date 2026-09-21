-- Week 2 Assignment - Equipment Lending Desk Performance
-- week2_indexes.sql
-- Dr. Heather Wegwerth
-- CST 335 100 Data Management & Big Data Systems
-- Jeffrey Yabandith
-- 2 indexes on the columns that the team would filter on the most.

PRAGMA foreign_keys = ON;
DROP INDEX IF EXISTS idx_loan_student;
DROP INDEX IF EXISTS idx_loan_return;

CREATE INDEX idx_loan_student ON Loan (StudentID);

CREATE INDEX idx_loan_return ON Loan (ActualReturnDate);
