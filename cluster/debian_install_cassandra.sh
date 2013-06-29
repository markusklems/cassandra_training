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
# Author: Markus Klems (2013)

#distro=$(sudo cat /etc/lsb-release | echo `grep DISTRIB_CODENAME` | sed 's/DISTRIB_CODENAME=//')
echo "deb http://debian.datastax.com/community stable main" | sudo -E tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
sleep 2
sudo apt-get update -y
# Install DataStax Cassandra community edition
sudo apt-get install -y python-cql dsc12 libjna-java