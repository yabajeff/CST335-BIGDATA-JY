---Dr. Heather Wegwerth
---CST 335 100 Data Management & Big Data Systems
---Jeffrey Yabandith

-- the star schema for an equipment lending analytics warehouse

DROP TABLE IF EXISTS fact_loans;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_item;
DROP TABLE IF EXISTS dim_campus;

CREATE TABLE dim_date (
    date_key   INTEGER PRIMARY KEY,   -- YYYYMMDD
    full_date  DATE,
    year       INTEGER,
    month      INTEGER,
    day        INTEGER,
    semester   VARCHAR
);

CREATE TABLE dim_item (
    item_key       INTEGER PRIMARY KEY,
    item_category  VARCHAR,
    item_type      VARCHAR
);

CREATE TABLE dim_campus (
    campus_key   INTEGER PRIMARY KEY,
    campus_name  VARCHAR
);

CREATE TABLE fact_loans (
    loan_key            INTEGER PRIMARY KEY,                     -- surrogate key
    date_key            INTEGER REFERENCES dim_date(date_key),   -- checkout date
    item_key            INTEGER REFERENCES dim_item(item_key),
    campus_key          INTEGER REFERENCES dim_campus(campus_key),
    loan_count          INTEGER,   -- measure: always 1 per loan
    loan_duration_days  INTEGER,   -- measure: days item was out
    is_overdue          INTEGER    -- measure/flag: 1 = overdue, 0 = returned on time
);
