#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP_ADDRESS=$1

# sudo wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster_7.6.6-1ubuntu18.04_amd64.deb-bundle.tar
# sudo mkdir mysql-cluster
# sudo tar -xvf mysql-cluster_7.6.6-1ubuntu18.04_amd64.deb-bundle.tar -C mysql-cluster/
# cd mysql-cluster
# sudo dpkg -i mysql-common_7.6.6-1ubuntu18.04_amd64.deb
# sudo dpkg -i mysql-cluster-community-client_7.6.6-1ubuntu18.04_amd64.deb
# sudo dpkg -i mysql-client_7.6.6-1ubuntu18.04_amd64.deb
# sudo dpkg -i mysql-cluster-community-server_7.6.6-1ubuntu18.04_amd64.deb
# sudo dpkg -i mysql-server_7.6.6-1ubuntu18.04_amd64.deb

# cd ..

# sudo mkdir -p /etc/mysql/
# sudo touch /etc/mysql/my.cnf
# echo "[mysqld]" | sudo tee -a /etc/mysql/my.cnf
# echo "ndbcluster" | sudo tee -a /etc/mysql/my.cnf
# echo "[mysql_cluster]" | sudo tee -a /etc/mysql/my.cnf

# # "sudo vim my.cnf" enter file press key "s" then edit when finish press "esc" then type ":w" and "enter" then type ":q" and "enter"
# echo "ndb-connectstring=ip-${IP_ADDRESS//./-}-ec2.internal" | sudo tee -a /etc/mysql/my.cnf

# source /etc/mysql/my.cnf 

# sudo systemctl restart mysql
# sudo systemctl enable mysql

sudo /opt/mysqlcluster/home/mysqlc/bin/mysqld --defaults-file=/opt/mysqlcluster/deploy/conf/my.cnf --user=root &

sudo wget http://downloads.mysql.com/docs/sakila-db.zip
unzip sakila-db.zip -d /tmp

mysql -u root -e  "SOURCE /tmp/sakila-db/sakila-schema.sql"
mysql -u root -e  "SOURCE /tmp/sakila-db/sakila-data.sql"

sudo mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY '123';"
sudo mysql -e "GRANT ALL PRIVILEGES on sakila.* TO 'root'@'%';"

mysql -u root -e "FLUSH PRIVILEGES"

sudo sysbench /usr/share/sysbench/oltp_read_write.lua prepare --db-driver=mysql --mysql-host=ip-${IP_ADDRESS//./-}.ec2.internal --mysql-db=sakila --mysql-user=root --mysql-password=123 --table-size=1000000 
sudo sysbench /usr/share/sysbench/oltp_read_write.lua run --db-driver=mysql --mysql-host=ip-${IP_ADDRESS//./-}.ec2.internal --mysql-db=sakila --mysql-user=root --mysql-password=123 --table-size=1000000 --threads=8 --time=20 --events=0 | sudo tee -a mysql-cluster-results

ndb_mgmd --ndb-mgmd-host=${IP_ADDRESS} --ndb-nodeid=1