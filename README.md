# log8415-personal-project

# prerequisites
- have terraform install on machine
- set path for terraform executable

# instructions to run code
- sign in accout
- copy aws_access_key_id and paste in variable.tf
- copy aws_secret_access_key and paste in variable.tf
- copy aws_session_token and paste in variable.tf
- run terraform once
- copy ip for standalone and paste it in main.tf in standalone resource
- copy ip for master and paste it in main.tf in master resource and in master_setup.sh and in slave_setup.sh
- copy ip for slave1 and paste it in main.tf in slave1 resource and in master_setup.sh
- copy ip for slave2 and paste it in main.tf in slave2 resource and in master_setup.sh
- copy ip for slave3 and paste it in main.tf in slave3 resource and in master_setup.sh
- type in command "terraform destroy"
- rerun terraform init
- rerun terraform apply

# destroy resource
- terraform destroy


# sources
# MySQL
- https://www.linode.com/docs/guides/install-mysql-on-ubuntu-14-04/
- ndb_mgmd 
- SHOW
- all report memoryusage
- https://stackoverflow.com/questions/43313528/data-nodes-cannot-connect-to-mysql-cluster 
- sudo kill -9 <pid>
- sudo systemctl stop ndb_mgmd
- ndb_mgmd --initial --configdir=/opt/mysqlcluster/deploy/conf/ --ndb-nodeid=1
- sudo ndb_mgmd --initial --configdir=/opt/mysqlcluster/home/mysqlc/bin/ndb_mgmd --ndb-nodeid=1
- sudo /opt/mysqlcluster/home/mysqlc/bin/ndb_mgmd -f /opt/mysqlcluster/deploy/conf/config.ini --initial --configdir=/opt/mysqlcluster/deploy/conf/


# sakila
- https://www.sqliz.com/sakila/installation/
- https://dev.mysql.com/doc/sakila/en/sakila-installation.html

# benchmarks
- https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql
- https://severalnines.com/blog/how-benchmark-performance-mysql-mariadb-using-sysbench/ 

# modifications
- if code is modified, delete ".tfplan" file
- then run commands in section "instructions to run code"


