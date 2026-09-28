# Week 3 - Relational vs. Document Modeling in MongoDB
Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith
## tables

**Student**
- StudentID (PK)
- FirstName
- LastName
- Email
- Major

**AdvisingNote**
- NoteID (PK)
- StudentID (FK)
- NoteDate
- AdvisorName
- Category
- NoteText

**SupportVisit**
- VisitID (PK)
- StudentID (FK)
- VisitDate
- ServiceType (tutoring, writing center, workshop)
- Description

## relationships

- AdvisingNote.StudentID is referencing Student.StudentID (one student can have many notes).
- SupportVisit.StudentID is referencing Student.StudentID (one student can have many visits).
- Each note and each visit will belong to exactly one student.
