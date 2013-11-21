#!/bin/bash
hosts=${1:-localhost}

cassandra-stress -d $hosts
