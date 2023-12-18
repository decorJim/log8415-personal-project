# log8415-personal-project

# prerequisites
- have terraform install on machine
- set path for terraform executable

# instructions to run code
- go to file variables.tf 
- change "aws_access_key_id.default", "aws_secret_access_key.default" and "aws_session_token.default" to the one found in your CLI details
- enter command "terraform init"
- enter command "terraform apply"
- when step of cluster installation finishes
- log into the master ec2 instance
- copy the privateIp of the machine written below
- go to "/" then to "/app"
- enter command "bash check.sh privateIp"
- wait for results

# sources
# MySQL
- https://www.linode.com/docs/guides/install-mysql-on-ubuntu-14-04/
- ndb_mgmd 
- SHOW
- all report memoryusage
- https://stackoverflow.com/questions/43313528/data-nodes-cannot-connect-to-mysql-cluster 
- sudo kill -9 <pid>
- sudo systemctl stop ndb_mgmd


# sakila
- https://www.sqliz.com/sakila/installation/
- https://dev.mysql.com/doc/sakila/en/sakila-installation.html

# benchmarks
- https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql
- https://severalnines.com/blog/how-benchmark-performance-mysql-mariadb-using-sysbench/ 

# modifications
- if code is modified, delete ".tfplan" file
- then run commands in section "instructions to run code"
