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

DC=${1:-DC1}
RACK=${2:-RACK1}

if [ -f /etc/cassandra/cassandra.yaml ]; then
  config_file="/etc/cassandra/cassandra.yaml"
fi
if [ -f /etc/cassandra/conf/cassandra.yaml ]; then
  config_file="/etc/cassandra/conf/cassandra.yaml"
fi
sed -i -e "s|endpoint_snitch: SimpleSnitch|endpoint_snitch: GossipingPropertyFileSnitch|" $config_file

topology_file="/etc/cassandra/cassandra-rackdc.properties"
if [ -f /etc/cassandra/conf/cassandra-topology.properties ]; then
  topology_file="/etc/cassandra/conf/cassandra-rackdc.properties"
  sudo rm $topology_file
fi
sudo touch $topology_file
echo "dc=$DC" | sudo tee -a $topology_file
echo "rack=$RACK" | sudo tee -a $topology_file

sudo cassandra service restart