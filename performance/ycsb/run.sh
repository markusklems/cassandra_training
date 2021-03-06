#!/bin/bash

records=${1:-500000}
workload=${2:-workloada}
ops=${3:-500000}
hosts=${4:-127.0.0.1}

ycsb-0.1.4/bin/ycsb run cassandra-10 -P ycsb-0.1.4/workloads/$workload -s -threads 10 -p recordcount=$records -p operationcount=$ops -p histogram.buckets=50 -p hosts=$hosts
