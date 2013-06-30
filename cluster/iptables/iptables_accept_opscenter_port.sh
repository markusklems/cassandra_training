#!/usr/bin/env bash -ex

for ip in $@
do
  echo "Accept Opscenter traffic on port 61620 and 61621 with $ip"
  sudo iptables -I INPUT -p tcp -m tcp -s $ip --dport 61620 -j ACCEPT
  sudo iptables -I INPUT -p tcp -m tcp -s $ip --dport 61621 -j ACCEPT
  sudo iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 61620 -j ACCEPT
  sudo iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 61621 -j ACCEPT
done