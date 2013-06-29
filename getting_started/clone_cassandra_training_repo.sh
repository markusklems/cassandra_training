#!/usr/bin/env bash -ex
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This script is dervied from the whirr scripts https://github.com/apache/whirr/tree/branch-0.8/core/src/main/resources/functions
#
# Author: Markus Klems (2013)

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