# CST 335 Week 4 - Distributed Storage and Data Lake Simulation

---Dr. Heather Wegwerth
---CST 335 100 Data Management & Big Data Systems
---Jeffrey Yabandith

-- duckdb -c ".read week4_queries.sql"
-- partitioning notes:
-- The lake folders are named year=YYYY then month=MM. With hive_partitioning = true,
-- DuckDB will turn these folder names into the columns named approriately "year" and "month".
-- When a query filters on year or month, DuckDB can tell it from the folder name
-- alone which files it needs, so it skips the other folders without having to open them.
-- Query 1 only needs year=2025/month=01. Query 2 should skip the year=2024 folder.
-- (month is read as a text because of the initial zero, so the filter is month = '01'.)
-- With 30 rows the speed difference is not that noticeable, but on a real lake with real data
-- this is what will keep a query from scanning every single file.

CREATE VIEW loans AS
SELECT *
FROM read_csv('lake/loans/*/*/*.csv', hive_partitioning = true);

--query 1: loans per item category for January 2025
SELECT item_category, COUNT(*) AS loan_count
FROM loans
WHERE year = 2025 AND month = '01'
GROUP BY item_category
ORDER BY loan_count DESC;

-- query 2: total loans per campus for 2025
SELECT campus, COUNT(*) AS loan_count
FROM loans
WHERE year = 2025
GROUP BY campus
ORDER BY loan_count DESC;
