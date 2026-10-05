# CST 335 Week 4 - Distributed Storage and Data Lake Simulation
# failure sim

Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith

## what had failed

I had simulated a failure of node2 by renaming the folder to:

```
cluster/node2  ->  cluster/node2_failed

```
Node2 then held these two blocks, so then those copies were lost:

- block1_loans_2025_01.csv
- block2_loans_2025_02.csv

## why the data is still safe

The replication factor is at 2, so each lost block had another copy on another node:

All 30 of the loan records could still be read and accessed from node1 and node3. No data is lost. However though, block1 and block2 themselves were down to one copy each, so a second failure at this point can mean lost data.

## the recovery steps

1. create a new folder named: `cluster/node2_replacement/`.
2. copy the file `block1_loans_2025_01.csv` from `node1` into `node2_replacement`.
3. copy the file `block2_loans_2025_02.csv` from `node3` into `node2_replacement`.
4. check that every block has 2 copies once again.

