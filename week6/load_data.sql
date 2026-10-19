---Dr. Heather Wegwerth
---CST 335 100 Data Management & Big Data Systems
---Jeffrey Yabandith

-- loads the CSV files from data/ into the star schema.
-- should run schema.sql first. dimensions will load before the fact table does so foreign keys match.

INSERT INTO dim_date   SELECT * FROM read_csv('data/dim_date.csv',   header = true);
INSERT INTO dim_item   SELECT * FROM read_csv('data/dim_item.csv',   header = true);
INSERT INTO dim_campus SELECT * FROM read_csv('data/dim_campus.csv', header = true);
INSERT INTO fact_loans SELECT * FROM read_csv('data/fact_loans.csv', header = true);

--- row count check
SELECT 'dim_date' AS table_name, COUNT(*) AS row_count FROM dim_date
UNION ALL SELECT 'dim_item', COUNT(*) FROM dim_item
UNION ALL SELECT 'dim_campus', COUNT(*) FROM dim_campus
UNION ALL SELECT 'fact_loans', COUNT(*) FROM fact_loans;
