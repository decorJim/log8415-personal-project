#!/bin/bash
IP_ADDRESS_1=$1

# install sakila
sudo wget https://downloads.mysql.com/docs/sakila-db.zip
sudo unzip sakila-db.zip
cd sakila-db

mysql -u root -e "SOURCE sakila-schema.sql;"
mysql -u root -e "SOURCE sakila-data.sql;"

# test queries
mysql -u root -e "USE sakila; SHOW FULL TABLES;"
mysql -u root -e "USE sakila; SELECT COUNT(*) FROM film;"

mysql -u root -e "GRANT ALL PRIVILEGES ON sakila.* TO 'root'@'%' IDENTIFIED BY '' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES"

sudo apt install sysbench

# perform benchmark
sysbench /usr/share/sysbench/oltp_read_write.lua prepare --db-driver=mysql --mysql-host=ip-${IP_ADDRESS_1//./-}.ec2.internal --mysql-db=sakila --mysql-user=root --mysql-password --table-size=1000000 
sysbench /usr/share/sysbench/oltp_read_write.lua run --db-driver=mysql --mysql-host=ip-${IP_ADDRESS_1//./-}.ec2.internal --mysql-db=sakila --mysql-user=root --mysql-password --table-size=1000000 --threads=8 --time=20 --events=0 | sudo tee -a mycluster_results
sysbench /usr/share/sysbench/oltp_read_write.lua cleanup --db-driver=mysql --mysql-host=ip-${IP_ADDRESS_1//./-}.ec2.internal --mysql-db=sakila --mysql-user=root --mysql-password 
