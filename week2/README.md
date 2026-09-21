# Week 2 - Equipment Lending Desk Performance
Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith
## the scenario
The equipment lending desk has been using the database I built in Week 1 long enough that there is 'real' data in it now, and some of the reports feeling slow according to the team. My job this week is to look at the queries they are running the most, figure out why these queries are getting slower as the table is growing in size, as well as, make small changes so that the database will do less work in order to get the same answer. I also tried to use a counting question in DuckDB against a CSV file and a Parquet file to see if the file format will make a difference. (It should)

The data is bigger than Week 1 intentionally. Week 1 has 6 loans, which can't be slow. This version will have 8 students, 10 items, and 120 loans spread from September 2025 to September 2026, so filtering them by a date range actually removes rows instead of matching all of them.

## the files

- `week2_schema.sql` - creates the Student, Item, and Loan.
- `week2_data.sql` - data of 8 students, 10 items, 120 loans.
- `week2_queries_baseline.sql` - the three before queries.
- `week2_indexes.sql` - creates the two indexes needed. 
- `week2_queries_optimized.sql` - the same three questions rephrased.
- `week2_duckdb.sql` - the CSV vs Parquet mini experiment, runs in DuckDB.
- `week2_notes.txt` - query plans and timings straight out of the terminal.
- `data/loan.csv` - the loan data in one file, with the student name and item category joined in.
- `data/loan.parquet` - will get created when you run step 3 of `week2_duckdb.sql`.

## baseline queries

1. **Full activity reporting.** Every loan joined to the student and the item. Written as `SELECT *` with no WHERE, so it was returning all of the 120 loans as well as every column from all three tables.
2. **103 student's loans .** `WHERE StudentID = 103`. Only 13 of the 120 rows are matching.
3. **What is currently checked out right now.** `WHERE ActualReturnDate IS NULL`. Only 3 of the 120 rows are matching.

Queries 2 and 3 are the more interesting ones, because both of them are asking for a small piece of the table and both were reading the whole table to find it.

## indexes and why I created them 

**`idx_loan_student` on `Loan(StudentID)`** - every "what has this student borrowed" lookup filters on this column, and all three of my queries join through it. SQLite indexes a primary key by itself, but it doesn't do the column that points at one, so this side had nothing to help it.

**`idx_loan_return` on `Loan(ActualReturnDate)`** - "what is out right now" is the question that the staff will ask the most and it is always the same filter. Only 3 of the 120 rows are open, so this is the one that skips the most work.

## what changed between baseline and optimized queries

The clearest change is with the query plan. Before integrating the indexes, the plan for the student lookup was `SCAN Loan`. Afterwards, it became `SEARCH Loan USING INDEX idx_loan_student`. SCAN means that SQLite had opened up the table and read every row from the top, and also checking each one. SEARCH means it used the index to go straight to the rows that tagged and matched. What was suprising to me was that I didn't change that query at all inbetween the two runs. Only the index had existed. So an index is a separate statement from how you write the query, and it can also help a query that you have never touched. Interesting. 

The other change is with the queries themselves. I had replaced the `SELECT *` with just the columns each of the report prints, and also added a date filter to the activity report so that it will cover this semester instead of looking at a full year, which took it from down 120 rows to 18. `SELECT *` itself looked harmless when I wrote it the first time in Week 1, but it just makes the database put together columns that nobody will read, in turn doing more work than needed.

On timing, The times mostly came back between 0.014000 and 0.019000. They move around between runs but nothing signifcant was observed when testing. That is a size problem though and I think my queries and indexes ran fine. The plan change is the real evidence at this level, and it is the thing that kept mattering as the table got bigger, since a full scan would get slower in step with the number of rows while an index lookup would barely change.

## DuckDB: CSV vs Parquet

I exported the loan data to `data/loan.csv` with the student name and item category already joined in, then ran the same category count against the CSV and against a Parquet copy of it. Both files gave the same five rows, which is the first thing I checked.

The plans were different at the bottom. The CSV version ends in `READ_CSV_AUTO` and the Parquet version ends in `PARQUET_SCAN`. The Parquet file was also significantly smaller (atleast 1/2) than the CSV even though it holds the same 120 rows.

What I took from this is that the two formats store the same data in a different shapes kind of. A CSV will keep each row together on one line of text, so in order to get at one column it would still have to read through every line and count commas to find out where that column would be. Parquet solves this by keeping each column together instead. My query only cares about `ItemCategory`, which is 1 of the 10 columns in the file, so with Parquet it can read that column and in turn then skip the rest. That is also why it would compresses smaller, since a whole column of dates or a whole column of five repeating category names has a lot of similar values sitting right next to each other, easily compressable. 

## running SQLite and DuckDB
In SQLite, from the project folder:
```
sqlite3 lending2.db
```
```
.read week2_schema.sql
.read week2_data.sql
.read week2_queries_baseline.sql
.read week2_indexes.sql
.read week2_queries_optimized.sql
```
run the baseline file before the indexes file, or there is no "before" to compare to when ran.
much like in Week 1, SQLite does not enforce foreign keys unless you run `PRAGMA foreign_keys = ON;`, and it will only apply to the connection you are in, so each script has to start with that line.

For the DuckDB part, from the same folder:
```
duckdb
```
```
.read week2_duckdb.sql
```
## AI assistance

AI assistance: 
For AI assistance I ended up using Claude 2 separate times to help me with this assignment. Firstly being that I needed more sample data to work with for the assignment. Since it required atleast 100 to 200 rows of data, I ended up using about 120 values for the Insert Statements that were given to me by Claude instead of making up 120 different checkout dates and data. I also came to the realization that indexes are separate from how the query itself is written. I was confused with the outputs since I saw that SCAN was outputting before I had added the index and SEARCH. After asking Claude and It clearing it up for me did I realize they were separate entities and did not to edit one to change the other.
