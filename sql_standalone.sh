#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

# install mysql server
sudo apt-get install mysql-server -y
sudo apt-get install unzip -y
sudo apt-get install sysbench -y

# install sakila
wget http://downloads.mysql.com/docs/sakila-db.zip
unzip sakila-db.zip

mysql -e "SOURCE /sakila-db/sakila-schema.sql;"
mysql -e "SOURCE /sakila-db/sakila-data.sql;"

# user to run benchmarks
mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY '123';"
mysql -e "GRANT ALL PRIVILEGES on sakila.* TO 'admin'@'localhost';"

# standalone results
sysbench --db-driver=mysql --mysql-db=sakila --mysql-user=admin --mysql_password=123 --table-size=50000 --tables=10 /usr/share/sysbench/oltp_read_write.lua prepare
sysbench --db-driver=mysql --mysql-db=sakila --mysql-user=admin --mysql_password=123 --table-size=50000 --tables=10 --threads=8 --max-time=20 /usr/share/sysbench/oltp_read_write.lua run > mysql-standalone-results
