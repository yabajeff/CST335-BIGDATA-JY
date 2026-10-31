# CST 335 Week 7 – student engagement with a mini lakehouse
--- Dr. Heather Wegwerth
--- CST 335 100 Data Management & Big Data Systems
--- Jeffrey Yabandith
## the structure
```
week7/
  lakehouse/
    engagement/
      year=2024/month=09/engagement_2024_09.csv   (15 rows, schema v1)
      year=2024/month=10/engagement_2024_10.csv   (15 rows, schema v1)
      year=2024/month=11/engagement_2024_11.csv   (12 rows, schema v2)
    metadata/
      engagement_table.yaml      (version 1)
      engagement_table_v2.yaml   (version 2)
  duckdb_queries/
    queries.sql
  schema_evolution.md
  lakehouse_reflection.md
  README.md

```
the data is partitioned by year and month using a Hive-style for the folder names (`year=YYYY/month=MM`). Each of the rows is one student engagement event (workshop, tutoring, or LMS-log). The data is made-up sample data from AI (see AI note)

## the metadata and schema evolution
`engagement_table.yaml` acts as a simple table spec. It lists the schema (column names and types), the partition keys (year, month), the version number, enforcement rules (required columns, allowed types and values, checks), schema evolution rules, and the files in the table.

`engagement_table_v2.yaml` is version 2. It adds the optional column `delivery_mode`. The September and October files use the version 1 schema. The November file uses version 2. Older files read `delivery_mode` as NULL. See `schema_evolution.md` for details.

## running the queries
run them from the `week7` folder (so that the `lakehouse/` paths resolve):

```
duckdb
.read duckdb_queries/queries.sql

```

## the queries
1. event counts for September only (partition pruning by path)
2. events by the campus for October (partition pruning by filter)
3. event count and the average duration by month and event type (combining the partitions + aggregation)
4. total tutoring visits and minutes at St. Paul (filtering by the event_type and campus)
5. the events by delivery_mode, with NULLs for any older files (handling the evolved column)

## AI assistance note
I used Claude to help me draft the sample data like engagement_tables 09-11 to work off of. I ran them in DuckDB to make sure each query worked as intended. 