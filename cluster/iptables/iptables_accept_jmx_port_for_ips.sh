#!/usr/bin/env bash -ex

for ip in $@
do
  echo "Accept JMX handshake traffic on port 7199 with $ip"
  sudo iptables -I INPUT -p tcp -m tcp -s $ip --dport 7199 -j ACCEPT
  sudo iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 7199 -j ACCEPT
  echo "Accept JMX after-handshake traffic on some random port 1024+ with $ip"
  sudo iptables -I INPUT -p tcp -m tcp -s $ip --dport 1024:65535 -j ACCEPT
  sudo iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 1024:65535 -j ACCEPT
done