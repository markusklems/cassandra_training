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

for ip in $@
do
  echo "Accept incoming and outgoing traffic on port 7000 and 7001 from $ip"
  iptables -I INPUT -p tcp -m tcp -s $ip --dport 7000 -j ACCEPT
  iptables -I INPUT -p tcp -m tcp -s $ip --dport 7001 -j ACCEPT
  iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 7000 -j ACCEPT
  iptables -I OUTPUT -p tcp -m tcp -d $ip --dport 7001 -j ACCEPT
done
iptables -I INPUT -p tcp -m tcp -s 0.0.0.0/0 --dport 7000 -j DROP
iptables -I INPUT -p tcp -m tcp -s 0.0.0.0/0 --dport 7001 -j DROP
iptables -I OUTPUT -p tcp -m tcp -d 0.0.0.0/0 --dport 7000 -j DROP
iptables -I OUTPUT -p tcp -m tcp -d 0.0.0.0/0 --dport 7001 -j DROP