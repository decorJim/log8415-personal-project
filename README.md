# log8415-personal-project

# prerequisites
- have terraform install on machine
- set path for terraform executable

# instructions to run code
- sign in accout
- manually create temporary instance
- copy paste temporary instance private ip in gatekeeper_private_ip variable in file variable.tf
- delete temporary instance

- copy aws_access_key_id and paste in variable.tf
- copy aws_secret_access_key and paste in variable.tf
- copy aws_session_token and paste in variable.tf

- copy aws_access_key_id and paste in proxy.sh
- copy aws_secret_access_key and paste in proxy.sh
- copy aws_session_token and paste in proxy.sh

- run terraform once with all resource (make sure to keep the values of private ip of resource and the keyname of proxy to null in variable.tf)
- copy all private ip of resources from in terminal and paste them in variable.tf file in appropriate section
- copy all private ip of resources from in terminal and paste them in master_setup.sh, slavve_setup.sh and proxy.sh
- use command git clone "https://github.com/decorJim/proxy-app.git", "https://github.com/decorJim/trusted-host.git" and 
"https://github.com/decorJim/gatekeeper.git"
- ideally all repo should be private and add in credentials in scripts to clone
- delete any existing keys inside the repos
- from your aws account create a new key-pair in .pem format named "tmp1.pem" on your local computer and add it inside the proxy-app, trusted-host and gatekeeper directory
- push it
- paste the keyname at the variable in resource "master, slave1, slave2, slave3, proxy, trustedhost, gatekeeper" keyname variable in main.tf

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


