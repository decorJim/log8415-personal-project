#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <IP_ADDRESS_1> <IP_ADDRESS_2> <IP_ADDRESS_3> <IP_ADDRESS_4>"
    exit 1
fi

IP_ADDRESS_1=$1
IP_ADDRESS_2=$2
IP_ADDRESS_3=$3
IP_ADDRESS_4=$4

mkdir -p /opt/mysqlcluster/home
cd /opt/mysqlcluster/home

wget http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.2/mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
tar xvf mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
ln -s mysql-cluster-gpl-7.2.1-linux2.6-x86_64 mysqlc

echo 'export MYSQLC_HOME=/opt/mysqlcluster/home/mysqlc' > /etc/profile.d/mysqlc.sh
echo 'export PATH=$MYSQLC_HOME/bin:$PATH' >> /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh
sudo apt-get update && sudo apt-get -y install libncurses5

mkdir -p /opt/mysqlcluster/deploy
mkdir -p /opt/mysqlcluster/home/mysqlc
cd /opt/mysqlcluster/deploy
mkdir -p conf
mkdir -p mysqld_data
mkdir -p ndb_data

sudo chmod +w ./conf

# Create and write to my.cnf file
sudo cat <<EOL > conf/my.cnf
[mysqld]
ndbcluster
datadir=/opt/mysqlcluster/deploy/mysqld_data
basedir=/opt/mysqlcluster/home/mysqlc
port=3306
EOL

echo "[ndb_mgmd]
hostname=ip-${IP_ADDRESS_1//./-}.ec2.internal
datadir=/opt/mysqlcluster/deploy/ndb_data
nodeid=1

[ndbd default]
noofreplicas=3
datadir=/opt/mysqlcluster/deploy/ndb_data

[ndbd]
hostname=ip-${IP_ADDRESS_2//./-}.ec2.internal
nodeid=2

[ndbd]
hostname=ip-${IP_ADDRESS_3//./-}.ec2.internal
nodeid=3

[ndbd]
hostname=ip-${IP_ADDRESS_4//./-}.ec2.internal
nodeid=4

[mysqld]
nodeid=50" | sudo tee conf/config.ini

cd /opt/mysqlcluster/home/mysqlc
sudo scripts/mysql_install_db --no-defaults --datadir=/opt/mysqlcluster/deploy/mysqld_data
sudo chown -R root /opt/mysqlcluster/home/mysqlc
sudo /opt/mysqlcluster/home/mysqlc/bin/ndb_mgmd -f /opt/mysqlcluster/deploy/conf/config.ini --initial --configdir=/opt/mysqlcluster/deploy/conf/
ndb_mgm -e show
sudo /opt/mysqlcluster/home/mysqlc/bin/mysqld --defaults-file=/opt/mysqlcluster/deploy/conf/my.cnf --user=root &

ndb_mgm -e show

sudo git clone https://github.com/decorJim/log8415-personal-project.git