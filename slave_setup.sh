#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP_ADDRESS=$1

sudo apt-get update -y
sudo apt-get install -y sysbench
sudo mkdir -p /opt/mysqlcluster/home
cd /opt/mysqlcluster/home

sudo wget http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.2/mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
sudo tar xvf mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
sudo ln -s mysql-cluster-gpl-7.2.1-linux2.6-x86_64 mysqlc
echo "export MYSQLC_HOME=/opt/mysqlcluster/home/mysqlc" | sudo tee -a /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh
echo "export PATH=$MYSQLC_HOME/bin:$PATH" | sudo tee -a /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh
sudo apt-get update && sudo apt-get -y install libncurses5
sudo mkdir -p /opt/mysqlcluster/deploy/ndb_data
sudo ndbd -c ip-${IP_ADDRESS//./-}.ec2.internal:1186
ndb_mgm -e show