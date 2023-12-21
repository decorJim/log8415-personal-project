#!/bin/bash
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
sudo apt-get install -y sysbench unzip expect
sudo mkdir -p /opt/mysqlcluster/home
sudo wget -O /opt/mysqlcluster/home/mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.2/mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
sudo tar xzf /opt/mysqlcluster/home/mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz --directory=/opt/mysqlcluster/home
sudo ln -s mysql-cluster-gpl-7.2.1-linux2.6-x86_64 /opt/mysqlcluster/home/mysqlc
echo "export MYSQLC_HOME=/opt/mysqlcluster/home/mysqlc" | sudo tee -a /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh
echo "export PATH=$MYSQLC_HOME/bin:$PATH" | sudo tee -a /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh
sudo apt-get update && sudo apt-get -y install libncurses5
sudo mkdir -p /opt/mysqlcluster/deploy
sudo mkdir -p /opt/mysqlcluster/deploy/conf
sudo mkdir -p /opt/mysqlcluster/deploy/mysqld_data
sudo mkdir -p /opt/mysqlcluster/deploy/ndb_data
     
sudo touch /opt/mysqlcluster/deploy/conf/my.cnf
echo "[mysqld]" | sudo tee -a /opt/mysqlcluster/deploy/conf/my.cnf
echo "ndbcluster" | sudo tee -a /opt/mysqlcluster/deploy/conf/my.cnf
echo "datadir=/opt/mysqlcluster/deploy/mysqld_data" | sudo tee -a /opt/mysqlcluster/deploy/conf/my.cnf
echo "basedir=/opt/mysqlcluster/home/mysqlc" | sudo tee -a /opt/mysqlcluster/deploy/conf/my.cnf
echo "port=3306" | sudo tee -a /opt/mysqlcluster/deploy/conf/my.cnf
     
sudo touch /opt/mysqlcluster/deploy/conf/config.ini
echo "[ndb_mgmd]" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "hostname=ip-${IP_ADDRESS_1//./-}.ec2.internal" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "datadir=/opt/mysqlcluster/deploy/ndb_data" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "nodeid=1" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "[ndbd default]" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "noofreplicas=3" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "datadir=/opt/mysqlcluster/deploy/ndb_data" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
     
echo "[ndbd]" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "hostname=ip-${IP_ADDRESS_2//./-}.ec2.internal" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "nodeid=2" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini

echo "[ndbd]" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "hostname=ip-${IP_ADDRESS_3//./-}.ec2.internal" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "nodeid=3" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini

echo "[ndbd]" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "hostname=ip-${IP_ADDRESS_4//./-}.ec2.internal" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "nodeid=4" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini

echo "[mysqld]" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini
echo "nodeid=50" | sudo tee -a /opt/mysqlcluster/deploy/conf/config.ini

sudo /opt/mysqlcluster/home/mysqlc/bin/ndb_mgmd -f /opt/mysqlcluster/deploy/conf/config.ini --initial --configdir=/opt/mysqlcluster/deploy/conf/

ndb_mgm -e show

ufw allow from $IP_ADDRESS_2
ufw allow from $IP_ADDRESS_3
ufw allow from $IP_ADDRESS_4



