#!/usr/bin/env bash -ex

echo "Accept outgoing traffic on port 8888 [WARNING: Do not do this in production!]"
sudo iptables -A INPUT -p tcp --dport 8888 -j ACCEPT