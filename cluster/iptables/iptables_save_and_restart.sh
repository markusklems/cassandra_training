#!/usr/bin/env bash -ex

sudo /sbin/service iptables save
sudo /sbin/service iptables restart