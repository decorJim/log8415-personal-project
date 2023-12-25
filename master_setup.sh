#!/bin/bash

# master
IP_ADDRESS_1=172.31.29.45

# slave 1
IP_ADDRESS_2=172.31.18.64
# slave 2
IP_ADDRESS_3=172.31.29.211
# slave 3
IP_ADDRESS_4=172.31.27.151

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install unzip

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

# CHANGE IP HERE
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


while ! mysqladmin ping --silent; do
    sleep 1
done

sudo wget https://downloads.mysql.com/docs/sakila-db.zip
sudo unzip sakila-db.zip
cd sakila-db

mysql -u root -e "SOURCE sakila-schema.sql;"
mysql -u root -e "SOURCE sakila-data.sql;"

mysql -u root -e "USE sakila; SHOW FULL TABLES;"
mysql -u root -e "USE sakila; SELECT COUNT(*) FROM film;"

mysql -u root -e "GRANT ALL PRIVILEGES ON sakila.* TO 'root'@'%' IDENTIFIED BY '' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES"

sudo sysbench /usr/share/sysbench/oltp_read_write.lua prepare --db-driver=mysql --mysql-host=ip-${IP_ADDRESS_1//./-}.ec2.internal --mysql-db=sakila --mysql-user=root --mysql-password --table-size=1000000 
sudo sysbench /usr/share/sysbench/oltp_read_write.lua run --db-driver=mysql --mysql-host=ip-${IP_ADDRESS_1//./-}.ec2.internal --mysql-db=sakila --mysql-user=root --mysql-password --table-size=1000000 --threads=8 --time=20 --events=0 > mycluster_results
sudo sysbench /usr/share/sysbench/oltp_read_write.lua cleanup --db-driver=mysql --mysql-host=ip-${IP_ADDRESS_1//./-}.ec2.internal --mysql-db=sakila --mysql-user=root --mysql-password 

