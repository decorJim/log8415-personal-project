#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP_ADDRESS=$1


sudo apt-get update -y
sudo apt-get install -y sysbench libncurses5

sudo mkdir -p /opt/mysqlcluster/home
cd /opt/mysqlcluster/home
sudo wget http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.2/mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
sudo tar xvf mysql-cluster-gpl-7.2.1-linux2.6-x86_64.tar.gz
sudo ln -s mysql-cluster-gpl-7.2.1-linux2.6-x86_64 mysqlc
echo "export MYSQLC_HOME=/opt/mysqlcluster/home/mysqlc" | sudo tee -a /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh
echo "export PATH=$MYSQLC_HOME/bin:$PATH" | sudo tee -a /etc/profile.d/mysqlc.sh
source /etc/profile.d/mysqlc.sh


sudo mkdir -p /opt/mysqlcluster/deploy/ndb_data
sudo chmod -R 777 /opt/mysqlcluster/deploy/ndb_data/

sudo ufw allow $IP_ADDRESS
sudo ufw allow 3306
sudo ufw allow 1186

MYSQL_CNF="/etc/mysql/conf.d/cluster.cnf"
sudo touch $MYSQL_CNF
echo "[mysqld]" | sudo tee -a $MYSQL_CNF
echo "ndbcluster" | sudo tee -a $MYSQL_CNF
echo "datadir=/opt/mysqlcluster/deploy/mysqld_data" | sudo tee -a $MYSQL_CNF
echo "basedir=/opt/mysqlcluster/home/mysqlc" | sudo tee -a $MYSQL_CNF
echo "port=3306" | sudo tee -a $MYSQL_CNF

sudo systemctl restart mysql || sudo service mysql restart

ndbd -c "ip-${IP_ADDRESS//./-}.ec2.internal:1186"

ndb_mgm -e show
