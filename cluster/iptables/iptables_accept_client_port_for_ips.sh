#!/usr/bin/env bash -ex

for ip in $@
do
  echo "Accept Cassandra client traffic on port 9160 with $ip"
  sudo iptables -I INPUT -p tcp -m tcp -s $ip --dport 9160 -j ACCEPT
  sudo iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 9160 -j ACCEPT
done