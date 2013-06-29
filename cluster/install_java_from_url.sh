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
#
# Install Oracle Java 1.6 or 1.7.

java_version=$1
url=$2

echo "Installing Java $1 from url $url"

target_java_dir='/opt/java/64'

tmpdir=`mktemp -d`
curl $url -L --silent --show-error --fail --connect-timeout 60 --max-time 600 --retry 5 -o $tmpdir/`basename $url`

if [ $java_version -e 6 ]; then
  (cd $tmpdir; sh `basename $url` -noregister)
  mkdir -p `dirname $target_dir`
  (cd $tmpdir; mv jdk1* $target_dir)
  rm -rf $tmpdir
elif [ $java_version -e 7 ]; then
  (cd $tmpdir; tar xzf `basename $url`)
  mkdir -p `dirname $target_dir`
  (cd $tmpdir; mv jdk1* $target_dir)
  rm -rf $tmpdir
else
  echo "Error. Please input either the number 6 or the number 7 as java version that you would like to install."
  return
fi

if which dpkg &> /dev/null; then
  update-alternatives --install /usr/bin/java java $target_dir/bin/java 17000
  update-alternatives --set java $target_dir/bin/java
elif which rpm &> /dev/null; then
  alternatives --install /usr/bin/java java $target_dir/bin/java 17000
  alternatives --set java $target_dir/bin/java
else
  # Assume there is no alternatives mechanism, create our own symlink
  ln -sf "$target_dir/bin/java" /usr/bin/java
fi

# Try to set JAVA_HOME in a number of commonly used locations
export JAVA_HOME=$target_dir
if [ -f /etc/profile ]; then
  echo export JAVA_HOME=$JAVA_HOME >> /etc/profile
fi
if [ -f /etc/bashrc ]; then
  echo export JAVA_HOME=$JAVA_HOME >> /etc/bashrc
fi
if [ -f ~root/.bashrc ]; then
  echo export JAVA_HOME=$JAVA_HOME >> ~root/.bashrc
fi
if [ -f /etc/skel/.bashrc ]; then
  echo export JAVA_HOME=$JAVA_HOME >> /etc/skel/.bashrc
fi

echo "Java installation script has finished."