# CST 335 Week 4 - Distributed Storage and Data Lake Simulation

Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith

## description

This project is reflecting a small distributed storage cluster and a data lake for a university equipment lending data. Everything is done in my local folders and CSV files. DuckDB is here for the queries used to run and view the data.

## cluster layout

- 3 nodes: `cluster/node1`, `cluster/node2`, `cluster/node3`
- 3 blocks (CSV files), one per month of loan data, with 10 rows each
- Replication factor at 2, so each block will be stored on the two nodes
- node2 was failed (it has been renamed to `node2_failed`) and its blocks were then restored to `node2_replacement`

Details are in `cluster_design.md` and `failure_simulation.md`.

## the lake layout

The loan data is partitioned by the year and month:

```
lake/loans/year=2024/month=12/loans_2024_12.csv
lake/loans/year=2025/month=01/loans_2025_01.csv
lake/loans/year=2025/month=02/loans_2025_02.csv

```

Details are in `lake_design.md`.

## files and their purposes

| `data_source/loans_sample.csv` | full sample data (30 rows of data) |
| `data_source/block*.csv` | the sample split into 3 separate blocks |
| `cluster/` | simulated nodes that hold block replicas |
| `lake/` | partitioned layout of the data lake |
| `cluster_design.md` | the cluster design and block placement |
| `failure_simulation.md` | node failures and the recovery |
| `lake_design.md` | lake partitioning explanation |
| `week4_queries.sql` | DuckDB queries |
| `integrity_reflection.md` -Reflection |

## how to reproduce

--- 1. ppen the folder in visual studio code and expand `cluster/` and `lake/` in the Explorer panel.

--- 2. open DuckDB, open a terminal in this folder, and then run this: 

```
duckdb -c ".read week4_queries.sql"

```

## AI assistance

AI assistance: I used Claude to help me generate the sample loan data since making this much data by hand can feel, monotonous. I just double checked that my queries came back good as well after testing them in DuckDB.  