#!/usr/bin/env bash -ex

#distro=$(sudo cat /etc/lsb-release | echo `grep DISTRIB_CODENAME` | sed 's/DISTRIB_CODENAME=//')
echo "deb http://debian.datastax.com/community stable main" | sudo -E tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
sleep 2
sudo apt-get update -y
# Install DataStax Cassandra community edition
sudo apt-get install -y python-cql dsc12 libjna-java