# CST 335 Week 4 - Distributed Storage and Data Lake Simulation
# overall lake design

Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith

## the layout

The loan data is partitioned by the year and month:

```
lake/
  loans/
    year=2024/month=12/loans_2024_12.csv
    year=2025/month=01/loans_2025_01.csv
    year=2025/month=02/loans_2025_02.csv

```

each file is a copy of one of the block files from `data_source/`, with 10 rows for each.

## how this supports queries by the date

The folder names store the year and month of the data inside of them. To find loans from a certain or specific month, you would only need to look in that month's folder. DuckDB will read the `year=` and `month=` folder names as columns, so a single query can filter on `year` and `month` directly.

## how this helps an analytics engine skip data

When a query has a filter for example like `year = 2025 AND month = '01'`, the engine can then compare the filter to the folder names before it ends up opening any files. Folders that do not match them are then skipped. In this specific project, a January 2025 query reads 1 of the 3 files, and a 2025 query reads 2 of the 3. With years of data, the same idea will then mean reading a few folders instead of the whole lake.
