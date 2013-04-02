#!/bin/bash
hosts=""
for host in $@; do
    hosts="$host,$hosts"
done
#remove last character
hosts=${hosts%?}
wget https://github.com/downloads/brianfrankcooper/YCSB/ycsb-0.1.4.tar.gz --no-check-certificate
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
create keyspace usertable with replication = {'class' : 'SimpleStrategy', 'replication_factor':1}; use usertable; create table data (key blob, column1 ascii, value blob, PRIMARY KEY(key,column1)) WITH COMPACT STORAGE;
END_OF_FILE

cqlsh -f create_ycsbtable
