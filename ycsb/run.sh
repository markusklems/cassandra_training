#!/bin/bash

records=${1:-500000}
workload=${2:-workloada}
ops=${3:-500000}

ycsb-0.1.4/bin/ycsb load cassandra-10 -P ycsb-0.1.4/workloads/$workload -s -threads 10 -target 1000 -p recordcount=$records ü operationcount=$ops -p histogram.buckets=50
