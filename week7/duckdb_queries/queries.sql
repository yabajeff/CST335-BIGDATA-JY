--- Dr. Heather Wegwerth
--- CST 335 100 Data Management & Big Data Systems
--- Jeffrey Yabandith
--- the lakehouse queries using DuckDB as running platform.
--- running from the week7 folder to make sure the lakehouse/ paths will resolve.
--- hive_partitioning means true turns the year=/month= folder names into separate columns.

--- query #1: the partition pruning starts- reading only the month=09 partition
--- only the files in the year=2024/month=09 are opened to be read. the other months are never scanned during this.
SELECT event_type, COUNT(*) AS event_count
FROM read_csv_auto('lakehouse/engagement/year=2024/month=09/*.csv')
GROUP BY event_type
ORDER BY event_type;

--- query #2: the partition pruning with a filter on the partition column itself
--- DuckDB will read all of the folders as one table, but the WHERE on month will let it skip that
--- the files which the folder doesn't match, the same way with the lakehouse engines prune partitions.
SELECT campus, COUNT(*) AS event_count
FROM read_csv_auto('lakehouse/engagement/*/*/*.csv', hive_partitioning = true, union_by_name = true)
WHERE year = 2024 AND month = 10
GROUP BY campus
ORDER BY campus;

--- query #3: combining multiple different partitions with aggregation
--- this query will then read all the months together and also roll them up by the month and event type as well.
SELECT month, event_type, COUNT(*) AS event_count, ROUND(AVG(duration_minutes), 1) AS avg_minutes
FROM read_csv_auto('lakehouse/engagement/*/*/*.csv', hive_partitioning = true, union_by_name = true)
GROUP BY month, event_type
ORDER BY month, event_type;

--- query #4: doing the filtering by the event_type and campus
--- this will read the total tutoring minutes at the St. Paul campus across all of the partitions.
SELECT COUNT(*) AS tutoring_visits, SUM(duration_minutes) AS total_minutes
FROM read_csv_auto('lakehouse/engagement/*/*/*.csv', hive_partitioning = true, union_by_name = true)
WHERE event_type = 'tutoring' AND campus = 'St. Paul';

--- query #5: the handling of an evolved column (a schema evolution)
--- the delivery_mode is only existing in month=11 files (the schema version 2).
--- union_by_name = true lines up columns by name, so the older files will return as NULL.
--- COALESCE is labeling these NULLs so that old and new data can be reported together in the end.
SELECT month,
       COALESCE(delivery_mode, 'not recorded') AS delivery_mode,
       COUNT(*) AS event_count
FROM read_csv_auto('lakehouse/engagement/*/*/*.csv', hive_partitioning = true, union_by_name = true)
GROUP BY month, delivery_mode
ORDER BY month, delivery_mode;

