  # Week 3 -  Relational vs. Document Modeling in MongoDB
Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith
## scenario

The university wants a simple "Student Success Hub" where the advisors can see a student's profile, their advising notes, and their visits to different support services such as tutoring, the writing center, and workshops. This project will model that data in two ways: relational and MongoDB.

## relational design summary

Three tables: Student, AdvisingNote, and SupportVisit. AdvisingNote and SupportVisit each have a StudentID foreign key that references Student.StudentID, so one student can have many notes and many visits.

## MongoDB design summary

One `students` collection. Each student document embeds an `advisingNotes` and `supportVisits`. I chose these to embed because advisors would usually look at one student at a time and the notes and visits only belong to that one student.

## comparison between the two

The relational design does feel the strongest when data integrity is what matters most and the data is shared or reported on in many different ways. Foreign keys and fixed columns do keep everything clean, and the SQL joins make it easy to ask any new questions across the students, notes, and or visits.

The MongoDB design feel the strongest however for the quick picture of a single student. One query will return the whole student with their notes and visits, and it is easy to add new fields later without having to change a schema. The downside with it is that the database does not enforce as many rules, so the validation has to be added intentionally.

## how to run

start MongoDB Community Edition.

open `mongosh` in a terminal.

copy and run `week3_mongo_commands.txt` to create the `student_success` database first and then insert the sample data. `db.students.countDocuments()` and it should return 5.

copy and run each query in `week3_mongo_queries.txt`. 

## files delivered

- relational_design.md
- mongo_design.md
- week3_mongo_commands.txt
- week3_mongo_queries.txt
- integrity_reflection.md
- README.md

## AI assistance

I used Claude for two different instances. First to help the sample data for the queries. I am not very creative with names or making whole individuals and found it easier to ask Claude with that part of the assignment. Second to double check why my queries came back with certain errors and for quality. 
