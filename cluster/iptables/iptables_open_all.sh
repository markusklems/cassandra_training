#!/usr/bin/env bash -ex

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

sudo /sbin/service iptables save
sudo /sbin/service iptables restart