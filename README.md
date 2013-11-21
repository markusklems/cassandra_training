Getting Started

1. `wget https://raw.github.com/markusklems/cassandra_training/master/getting_started/clone_cassandra_training_repo.sh`
2. `sudo sh clone_cassandra_training_repo.sh`
3. `rm clone_cassandra_training_repo.sh`
4. `(cd ~; git clone git://github.com/markusklems/cassandra_training.git)`
5. `sudo sh cassandra_training/cluster/install_java_from_url.sh <version={6,7}> <url>`
6.a If RHEL: `sudo sh cassandra_training/cluster/rhel_install_cassandra_and_opscenter.sh`
6.b If Debian/Ubuntu: `sudo sh cassandra_training/cluster/debian_install_cassandra_and_opscenter.sh`
7. `sudo sh cassandra_training/cluster/config/config_cluster.sh <seed_server>`