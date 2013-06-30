#!/usr/bin/env bash -ex

for ip in $@
do
  echo "Accept Opscenter traffic on port 61621 and 61622 with $ip"
  sudo iptables -I INPUT -p tcp -m tcp -s $ip --dport 61621 -j ACCEPT
  sudo iptables -I INPUT -p tcp -m tcp -s $ip --dport 61622 -j ACCEPT
  sudo iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 61621 -j ACCEPT
  sudo iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 61622 -j ACCEPT
done