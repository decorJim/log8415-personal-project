#!/bin/bash
exec > /var/log/cluster.log 2>&1

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <IP_ADDRESS_1> <IP_ADDRESS_2> <IP_ADDRESS_3> <IP_ADDRESS_4>"
    exit 1
fi

IP_ADDRESS_1=$1
IP_ADDRESS_2=$2
IP_ADDRESS_3=$3
IP_ADDRESS_4=$4

echo "IP1: $IP_ADDRESS_1, IP2: $IP_ADDRESS_2, IP3: $IP_ADDRESS_3, IP4 $IP_ADDRESS_4" > clusterip.txt

sudo apt update -y
sudo apt-get install -y sysbench unzip expect libncurses5

sudo mkdir -p /opt/mysqlcluster/home
cd /opt/mysqlcluster/home

sudo wget -O mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.2/mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
sudo tar xzf mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
sudo ln -s mysql-cluster-gpl-7.2.1-linux2.6-x86_64 mysqlc

echo "export MYSQLC_HOME=/opt/mysqlcluster/home/mysqlc" | sudo tee -a /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh
echo "export PATH=$MYSQLC_HOME/bin:$PATH" | sudo tee -a /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh
sudo apt-get update && sudo apt-get -y install libncurses5

# Create directories for MySQL Cluster deployment
sudo mkdir -p /opt/mysqlcluster/deploy
sudo mkdir -p /opt/mysqlcluster/home/mysqlc

cd /opt/mysqlcluster/deploy

sudo mkdir -p conf
sudo mkdir -p mysqld_data
sudo mkdir -p ndb_data
sudo chmod +w ./conf

# Create and configure the my.cnf file
sudo tee /opt/mysqlcluster/deploy/conf/my.cnf > /dev/null <<EOF
[mysqld]
ndbcluster
datadir=/opt/mysqlcluster/deploy/mysqld_data
basedir=/opt/mysqlcluster/home/mysqlc
port=3306
EOF

# Create and configure the config.ini file
sudo tee /opt/mysqlcluster/deploy/conf/config.ini > /dev/null <<EOF
[ndb_mgmd]
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
nodeid=50
EOF

cd /opt/mysqlcluster/home/mysqlc
sudo scripts/mysql_install_db --no-defaults --datadir=/opt/mysqlcluster/deploy/mysqld_data
sudo chown -R root /opt/mysqlcluster/home/mysqlc
sudo /opt/mysqlcluster/home/mysqlc/bin/ndb_mgmd -f /opt/mysqlcluster/deploy/conf/config.ini --initial --configdir=/opt/mysqlcluster/deploy/conf/

ndb_mgm -e show



