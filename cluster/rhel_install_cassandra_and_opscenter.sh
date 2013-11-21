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

# Install JNA
sudo yum install -y jna
	
# recommended by datastax
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm

# install cassandra
echo "[datastax]
name= DataStax Repo for Apache Cassandra
baseurl=http://rpm.datastax.com/community
enabled=1
gpgcheck=0

[opscenter]
name= DataStax Repository
baseurl=http://rpm.datastax.com/community
enabled=1
gpgcheck=0" | sudo tee -a /etc/yum.repos.d/datastax.repo

sudo yum update
sudo yum install -y dsc20 python-cql opscenter-free

sleep 5

myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
sudo sed -i -e "s|interface = 127.0.0.1|interface = $myip|" /etc/opscenter/opscenterd.conf

#sudo service opscenterd start