#!/usr/bin/env bash -ex
#
# Install Oracle Java 1.6 or 1.7.

java_version=$1
url=$2

echo "Installing Java $1 from url $url"

target_dir="/opt/java/64/oracle-java$java_version"
mkdir -p $target_dir

tmpdir=`mktemp -d`
echo "Start downloading ..."
basename_of_url=`basename $url`
curl $url -L --show-error --fail --connect-timeout 60 --max-time 600 --retry 5 -o "$tmpdir/$basename_of_url"

echo "Unpacking the downloaded file."
if [ $java_version -eq 6 ]; then
  (cd $tmpdir; sh $basename_of_url -noregister; rm -rf $basename_of_url)
  mkdir -p `dirname $target_dir`
  java_dir=`ls $tmpdir`
  (cd $tmpdir; mv j* $target_dir)
  rm -rf $tmpdir
elif [ $java_version -eq 7 ]; then
  (cd $tmpdir; tar xzf $basename_of_url; rm -rf $basename_of_url)
  mkdir -p `dirname $target_dir`
  java_dir=`ls $tmpdir`
  (cd $tmpdir; mv j* $target_dir)
  rm -rf $tmpdir
else
  echo "Error. Please input either the number 6 or the number 7 as java version that you would like to install."
  return
fi

if which dpkg &> /dev/null; then
  update-alternatives --install /usr/bin/java java "$target_dir/$java_dir/bin/java" 17000
  update-alternatives --set java "$target_dir/$java_dir/bin/java"
elif which rpm &> /dev/null; then
  alternatives --install /usr/bin/java java "$target_dir/$java_dir/bin/java" 17000
  alternatives --set java "$target_dir/$java_dir/bin/java"
else
  # Assume there is no alternatives mechanism, create our own symlink
  ln -sf "$target_dir/$java_dir/bin/java" /usr/bin/java
fi

# Try to set JAVA_HOME in a number of commonly used locations
export JAVA_HOME="$target_dir/$java_dir"
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
