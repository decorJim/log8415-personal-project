# log8415-personal-project

# prerequisites
- have terraform install on machine
- set path for terraform executable

# instructions to run code
- go to file variables.tf 
- change "aws_access_key_id.default", "aws_secret_access_key.default" and "aws_session_token.default" to the one found in your CLI details
- enter command "terraform init"
- enter command "terraform apply"

# sources
# MySQL
- https://www.linode.com/docs/guides/install-mysql-on-ubuntu-14-04/

# sakila
- https://www.sqliz.com/sakila/installation/
- https://dev.mysql.com/doc/sakila/en/sakila-installation.html

# benchmarks
- https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql
- https://severalnines.com/blog/how-benchmark-performance-mysql-mariadb-using-sysbench/ 

# modifications
- if code is modified, delete ".tfplan" file
- then run commands in section "instructions to run code"
