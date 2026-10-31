# the schema evolution
--- Dr. Heather Wegwerth
--- CST 335 100 Data Management & Big Data Systems
--- Jeffrey Yabandith

## what had changed between the two
the version 1 of the engagement table (`engagement_table.yaml`) had only six columns named: `event_id`, `student_id`, `event_type`, `event_date`, `duration_minutes`, and `campus`.

the version 2 of it (`engagement_table_v2.yaml`) adds one extra column called, `delivery_mode` (VARCHAR, nullable, allowed values `in-person` or `virtual` as well). The version number does go from 1 to 2. None of the existing columns were changed or removed in any way. 

## how old and new files will coexist with each other 
the September and October files were both written under the version 1 table and also don't have the `delivery_mode`. The November file was written under the version 2 table and does includes `delivery_mode`. Inside of a real lakehouse, rewriting the old files just to add an empty column to them would be way too slow and inefficient. Instead though, the table metadata will record which of the schema version each of the files were written with. When a query ends up reading the whole table, the engine will then use the latest schema and also will fill in NULL for the `delivery_mode` inside of the older files.

DuckDB does end up showing this with the `union_by_name = true`, which ends up lining the columns by each name across the files. Columns missing from a file come back as NULL (see Query 5 in `duckdb_queries/queries.sql`). The queries that are written before the change will still work because they only use the version 1 columns even though they can access the others. 
