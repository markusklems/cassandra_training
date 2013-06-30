#!/usr/bin/env bash -ex

for ip in $@
do
  echo "Accept traffic on Cassandra storage port 7000 and 7001 with $ip"
  iptables -I INPUT -p tcp -m tcp -s $ip --dport 7000 -j ACCEPT
  iptables -I INPUT -p tcp -m tcp -s $ip --dport 7001 -j ACCEPT
  iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 7000 -j ACCEPT
  iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 7001 -j ACCEPT
done
#iptables -I INPUT -p tcp -m tcp -s 0.0.0.0/0 --dport 7000 -j DROP
#iptables -I INPUT -p tcp -m tcp -s 0.0.0.0/0 --dport 7001 -j DROP
#iptables -I OUTPUT -p tcp -m tcp -d 0.0.0.0/0 --dport 7000 -j DROP
#iptables -I OUTPUT -p tcp -m tcp -d 0.0.0.0/0 --dport 7001 -j DROP