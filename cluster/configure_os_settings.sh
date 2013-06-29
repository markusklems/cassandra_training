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

# Avoid OS security limits to become a scalability bottleneck.
#sudo rm /etc/security/limits.conf
cat >limits.conf <<END_OF_FILE
* soft nofile 32768
* hard nofile 32768
root soft nofile 32768
root hard nofile 32768
* soft memlock unlimited
* hard memlock unlimited
root soft memlock unlimited
root hard memlock unlimited
* soft as unlimited
* hard as unlimited
root soft as unlimited
root hard as unlimited
END_OF_FILE
sudo mv limits.conf /etc/security/limits.conf
sudo chown root:root /etc/security/limits.conf
sudo chmod 755 /etc/security/limits.conf
# Disable swap
sudo swapoff --all
