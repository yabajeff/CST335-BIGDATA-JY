# CST 335 Week 4 - Distributed Storage and Data Lake Simulation
# cluster design

Dr. Heather Wegwerth
CST 335 100 Data Management & Big Data Systems
Jeffrey Yabandith

## nodes

running 3 nodes. Each node is a folder inside of `cluster/`:

```
cluster/
  node1/
  node2/
  node3/

```
## the replication factor

The replication factor is at 2. Every block is stored on two different nodes.

## how the layout is representing a distributed storage system

--- 1. the blocks: Each CSV file is on one block. I split the file `data_source/loans_sample.csv` (30 rows) into three blocks, one per month, with 10 rows each.
--- 2. the nodes: Each top-level folder under `cluster/` is one node. A real node would be a separate machine with its own disks.
--- 3. the replication factor: The same block file is copied into two node folders. If one folder is lost, the other copy is still there.

## each block placement (before failure)

each block has 2 copies each, and each node holds 2 blocks. No one node is holding both of the copies of the same block, so losing any of the  nodes does not lose any data.

