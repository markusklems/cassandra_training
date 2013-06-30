#!/usr/bin/env bash -ex
# Source: http://www.datastax.com/docs/1.2/initialize/token_generation#calculating-tokens-for-the-murmur3partitioner
number_of_tokes=$1
python -c "print [str(((2**64 / $number_of_tokes) * i) - 2**63) for i in range($number_of_tokes)]"