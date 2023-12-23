#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP_ADDRESS=$1


cd /

sudo wget http://downloads.mysql.com/docs/sakila-db.zip
unzip sakila-db.zip -d /tmp

mysql -u root -e  "SOURCE /tmp/sakila-db/sakila-schema.sql"
mysql -u root -e  "SOURCE /tmp/sakila-db/sakila-data.sql"

sudo mysql -e "CREATE USER 'root'@'localhost' IDENTIFIED BY '123';"
sudo mysql -e "GRANT ALL PRIVILEGES on sakila.* TO 'root'@'localhost';"

mysql -u root -e "FLUSH PRIVILEGES"

sudo sysbench /usr/share/sysbench/oltp_read_write.lua prepare --db-driver=mysql --mysql-host=localhost --mysql-db=sakila --mysql-user=root --mysql-password=123 --table-size=1000000 
sudo sysbench /usr/share/sysbench/oltp_read_write.lua run --db-driver=mysql --mysql-host=localhost --mysql-db=sakila --mysql-user=root --mysql-password=123 --table-size=1000000 --threads=8 --time=20 --events=0 | sudo tee -a mysql-cluster-results

ndb_mgm

