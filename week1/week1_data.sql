-- Week 1 Assignment - Campus Equipment Lending Desk
-- week1_data.sql
-- Dr. Heather Wegwerth
-- CST 335 100 Data Mangament & Big Data Systems 
-- Jeffrey Yabandith
PRAGMA foreign_keys = ON;
DELETE FROM Loan;
DELETE FROM Item;
DELETE FROM Student;
INSERT INTO Student (StudentID, FirstName, LastName, Email) VALUES
    (101, 'John',  'Smith', 'smithj@csp.edu'),
    (102, 'Jane', 'Doe', 'doej@csp.edu'),
    (103, 'Joe', 'Johnson', 'johnsonj@csp.edu');
INSERT INTO Item (ItemID, ItemName, Category, Status) VALUES
    (1, 'Dell Laptop', 'laptop','checked_out'),
    (2, 'MacBook Air Laptop','laptop','available'),
    (3, 'Canon EOS Camera','camera','checked_out'),
    (4, 'Shure Microphone','microphone','available'),
    (5, 'Epson Projector','projector','available');
INSERT INTO Loan
    (LoanID, StudentID, ItemID, CheckoutDate, ExpectedReturnDate, ActualReturnDate)
VALUES
    (1, 101, 2, '2026-08-25', '2026-09-01', '2026-08-31'),
    (2, 102, 3, '2026-08-26', '2026-09-02', '2026-09-05'),
    (3, 103, 5, '2026-08-28', '2026-09-04', '2026-09-04'),
    (4, 101, 4, '2026-09-01', '2026-09-08', '2026-09-08'),
    (5, 101, 1, '2026-09-08', '2026-09-15', NULL),
    (6, 102, 3, '2026-09-10', '2026-09-17', NULL);
