#!/bin/bash
hosts=""
for host in $@; do
    hosts="$host,$hosts"
done
#remove last character
hosts=${hosts%?}
#wget https://github.com/downloads/brianfrankcooper/YCSB/ycsb-0.1.4.tar.gz
wget https://s3-eu-west-1.amazonaws.com/97392738827291663210374/ycsb-0.1.4.tar.gz
tar xfvz ycsb-0.1.4.tar.gz
rm ycsb-0.1.4.tar.gz
# download bindings
wget http://archive.apache.org/dist/cassandra/1.0.9/apache-cassandra-1.0.9-bin.tar.gz
tar xfvz apache-cassandra-1.0.9-bin.tar.gz
cp apache-cassandra-1.0.9/lib/*.jar ycsb-0.1.4/cassandra-binding/.
rm -Rf apache-cassandra-1.0.9*
echo "hosts=$hosts" >> ycsb-0.1.4/workloads/workloada
chmod +x ycsb-0.1.4/bin/ycsb
# prepare cassandra keyspace for ycsb
cat >create_ycsbtable <<END_OF_FILE
create keyspace usertable with strategy_options = [{replication_factor:1}] and placement_strategy = 'org.apache.cassandra.locator.SimpleStrategy';
use usertable;
create column family data with comparator='AsciiType';
END_OF_FILE

cassandra-cli -h localhost -f create_ycsbtable
