#!/usr/bin/env bash -ex

# 1. Update
if which dpkg &> /dev/null; then
  sudo apt-get update
elif which rpm &> /dev/null; then
  sudo yum update
fi
#2. Install git
(wget https://raw.github.com/markusklems/cassandra_training/master/getting_started/install_git.sh; sudo sh install_git.sh; rm install_git.sh)
sleep 1
# 3. Clone cassandra_training repo
(cd ~; git clone git://github.com/markusklems/cassandra_training.git)