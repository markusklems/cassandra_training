#!/usr/bin/env bash -ex

echo "deb http://debian.datastax.com/community stable main" | sudo -E tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
curl -s http://opscenter.datastax.com/debian/repo_key | sudo apt-key add -
sudo apt-get update -y
# Install DataStax Cassandra community edition
sudo apt-get install -y python-cql dsc20 libjna-java
