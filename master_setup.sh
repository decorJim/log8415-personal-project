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

# Create directories for MySQL Cluster deployment
sudo mkdir -p /opt/mysqlcluster/deploy /opt/mysqlcluster/deploy/conf /opt/mysqlcluster/deploy/mysqld_data /opt/mysqlcluster/deploy/ndb_data

# Create and configure the my.cnf file
sudo cp /etc/mysql/my.cnf /etc/mysql/my.cnf.backup
sudo tee /etc/mysql/my.cnf > /dev/null <<EOF
[mysqld]
ndbcluster
datadir=/opt/mysqlcluster/deploy/mysqld_data
basedir=/opt/mysqlcluster/home/mysqlc
port=3306
bind-address=0.0.0.0
socket=/tmp/mysql.sock
[client]
socket=/tmp/mysql.sock
EOF

# Create and configure the config.ini file
sudo tee /opt/mysqlcluster/deploy/conf/config.ini > /dev/null <<EOF
[ndb_mgmd]
hostname=${IP_ADDRESS_1}
datadir=/opt/mysqlcluster/deploy/ndb_data
nodeid=1
[ndbd default]
noofreplicas=3
datadir=/opt/mysqlcluster/deploy/ndb_data
[ndbd]
hostname=${IP_ADDRESS_2}
nodeid=2
[ndbd]
hostname=${IP_ADDRESS_3}
nodeid=3
[ndbd]
hostname=${IP_ADDRESS_4}
nodeid=4
[mysqld]
hostname=${IP_ADDRESS_1}
nodeid=50
EOF

sudo ufw allow from $IP_ADDRESS_2
sudo ufw allow from $IP_ADDRESS_3
sudo ufw allow from $IP_ADDRESS_4
sudo ufw allow 3306
sudo ufw allow 1186

sudo /opt/mysqlcluster/home/mysqlc/bin/ndb_mgmd -f /opt/mysqlcluster/deploy/conf/config.ini --initial --configdir=/opt/mysqlcluster/deploy/conf/

ndb_mgm -e show
