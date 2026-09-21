-- Week 2 Assignment - Equipment Lending Desk Performance
-- week2_schema.sql
-- Dr. Heather Wegwerth
-- CST 335 100 Data Management & Big Data Systems
-- Jeffrey Yabandith
-- the same three tables from week 1. The only difference is that this week 
-- week2_data.sql has a lot more rows(114 more).
-- There are no indexes in this file on purpose. The indexes are in
-- week2_indexes.sql so that I can see what the queries will look like before and
-- after adding them in.

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