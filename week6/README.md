# CST 335 Week 6 – equipment lending analytics warehouse
---Dr. Heather Wegwerth
---CST 335 100 Data Management & Big Data Systems
---Jeffrey Yabandith

## the dimensional model
the star schema with one fact table and then three dimensions:

- **fact_loans** – `loan_key` (the surrogate primary key), `date_key`, `item_key`, `campus_key` (foreign keys), and measures `loan_count`, `loan_duration_days`, `is_overdue`
- **dim_date** – `date_key`, `full_date`, `year`, `month`, `day`, `semester`
- **dim_item** – `item_key`, `item_category`, `item_type`
- **dim_campus** – `campus_key`, `campus_name`

**Grain:** one row in `fact_loans` is equal to one equipment loan event (one item, one campus, and one checkout date). see more in `grain_definition.md`.

## the files
- `schema.sql` – creates the tables
- `load_data.sql` – loads the CSVs inside `data/`
- `olap_queries.sql` – the analytical queries
- `grain_definition.md`, `performance_reflection.md`
- `data/` – `dim_date.csv`, `dim_item.csv`, `dim_campus.csv`, `fact_loans.csv` (36 rows)

## running 
run from the project folder 

```
duckdb lending.duckdb
.read schema.sql
.read load_data.sql
.read olap_queries.sql

```

## the OLAP Queries
1. the total loans by month and item category (aggregation across two dimensions)
2. the average loan duration by each campus (aggregation of a measure)
3. the top 3 item categories by the annual usage (aggregation + ranking)
4. the loans by each semester and campus (dice)
5. the overdue vs. returned-on-time loans (grouping by a status flag)

## AI assistance 
Claude was used for making the 36 row sample data. the files and queries were ran in DuckDB to ensure they work. 
