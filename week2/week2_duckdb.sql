-- Week 2 Assignment - Equipment Lending Desk Performance
-- week2_duckdb.sql
-- Dr. Heather Wegwerth
-- CST 335 100 Data Management & Big Data Systems
-- Jeffrey Yabandith
-- The CSV vs Parquet experiment. This file is to be used in DuckDB
-- data/loan.csv is my loan data with the student name and the item
-- category already joined in together, so it is one unified file.
-- Start DuckDB from inside of the project folder:
--     duckdb
-- then:
--     .read week2_duckdb.sql

.timer on

-- step 1: counting the loans per category straight out of the CSV file.
-- DuckDB is able to read the file directly, so there is no loading step for this one here.
SELECT ItemCategory, COUNT(*) AS loan_count
FROM 'data/loan.csv'
GROUP BY ItemCategory
ORDER BY ItemCategory;

-- step 2: see how DuckDB plans it out. The bottom box should say READ_CSV_AUTO.
EXPLAIN
SELECT ItemCategory, COUNT(*) AS loan_count
FROM 'data/loan.csv'
GROUP BY ItemCategory
ORDER BY ItemCategory;

-- step 3: save the same data as a Parquet file.
COPY (SELECT * FROM 'data/loan.csv')
TO 'data/loan.parquet' (FORMAT PARQUET);

-- step 4: run the exact same query against the Parquet file and compare the two speeds if you would like.
-- the answer should come out the same. Only the speed should be different.
SELECT ItemCategory, COUNT(*) AS loan_count
FROM 'data/loan.parquet'
GROUP BY ItemCategory
ORDER BY ItemCategory;

-- step 5: this is the plan for the Parquet version. The bottom box should now say
-- PARQUET_SCAN instead of READ_CSV_AUTO.
EXPLAIN
SELECT ItemCategory, COUNT(*) AS loan_count
FROM 'data/loan.parquet'
GROUP BY ItemCategory
ORDER BY ItemCategory;