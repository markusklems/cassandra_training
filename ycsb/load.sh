#!/bin/bash

records=${1:-500000}
workload=${2:-workloada}
hosts=${3:-127.0.0.1}

ycsb-0.1.4/bin/ycsb load cassandra-10 -P ycsb-0.1.4/workloads/$workload -s -threads 10 -target 2000 -p recordcount=$records -p histogram.buckets=50 -p hosts=$hosts
