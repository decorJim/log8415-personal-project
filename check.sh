#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP_ADDRESS=$1

sudo wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster_7.6.6-1ubuntu18.04_amd64.deb-bundle.tar
sudo mkdir mysql-cluster
sudo tar -xvf mysql-cluster_7.6.6-1ubuntu18.04_amd64.deb-bundle.tar -C mysql-cluster/
cd mysql-cluster
sudo dpkg -i mysql-common_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-client_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-client_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-cluster-community-server_7.6.6-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-server_7.6.6-1ubuntu18.04_amd64.deb

cd ..

sudo mkdir -p /etc/mysql/
sudo touch /etc/mysql/file.cnf
echo "[mysqld]" | sudo tee -a /etc/mysql/file.cnf
echo "ndbcluster" | sudo tee -a /etc/mysql/file.cnf
echo "[mysql_cluster]" | sudo tee -a /etc/mysql/file.cnf

# "sudo vim file.cnf" enter file press key "s" then edit when finish press "esc" then type ":w" and "enter" then type ":q" and "enter"
echo "ndb-connectstring=ip-${IP_ADDRESS//./-}-ec2.internal" | sudo tee -a /etc/mysql/file.cnf
source /etc/mysql/file.cnf 

sudo systemctl restart mysql
sudo systemctl enable mysql

sudo wget http://downloads.mysql.com/docs/sakila-db.zip
unzip sakila-db.zip -d /tmp
sudo mysql -e "SOURCE /tmp/sakila-db/sakila-schema.sql;"
sudo mysql -e "SOURCE /tmp/sakila-db/sakila-data.sql;"
sudo mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY '123';"
sudo mysql -e "GRANT ALL PRIVILEGES on sakila.* TO 'admin'@'localhost';"
sysbench --db-driver=mysql --mysql-db=sakila --mysql-user=admin --mysql_password=123 --table-size=50000 --tables=10 /usr/share/sysbench/oltp_read_write.lua prepare
sysbench --db-driver=mysql --mysql-db=sakila --mysql-user=admin --mysql_password=123 --table-size=50000 --tables=10 --threads=8 --max-time=20 /usr/share/sysbench/oltp_read_write.lua run | sudo tee -a mysql-cluster-results