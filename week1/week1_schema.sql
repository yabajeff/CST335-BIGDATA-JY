-- Week 1 Assignment - Campus Equipment Lending Desk
-- week1_schema.sql
-- Dr. Heather Wegwerth
-- CST 335 100 Data Mangament & Big Data Systems
-- Jeffrey Yabandith
PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
    StudentID   INTEGER PRIMARY KEY,
    FirstName   TEXT    NOT NULL,
    LastName    TEXT    NOT NULL,
    Email       TEXT    NOT NULL UNIQUE
);
CREATE TABLE Item (
    ItemID      INTEGER PRIMARY KEY,
    ItemName    TEXT    NOT NULL,
    Category    TEXT    NOT NULL,
    Status      TEXT    NOT NULL DEFAULT 'available'
);
CREATE TABLE Loan (
    LoanID              INTEGER PRIMARY KEY,
    StudentID           INTEGER NOT NULL,
    ItemID              INTEGER NOT NULL,
    CheckoutDate        TEXT    NOT NULL,
    ExpectedReturnDate  TEXT    NOT NULL,
    ActualReturnDate    TEXT,

    FOREIGN KEY (StudentID) REFERENCES Student (StudentID),
    FOREIGN KEY (ItemID)    REFERENCES Item (ItemID)
);
