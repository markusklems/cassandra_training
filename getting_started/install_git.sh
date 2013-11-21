#!/usr/bin/env bash -ex

if which dpkg &> /dev/null; then
  sudo apt-get install -y git 
elif which rpm &> /dev/null; then
  sudo yum install -y git
fi