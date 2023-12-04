# credentials
provider "aws" {
  region = var.aws_region  # Replace with your AWS region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token = var.aws_session_token
}

# create security group
resource "aws_security_group" "my_group_1" {
  name        = var.security_group_name
  description = "Allow SSH inbound traffic"

  # rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks  
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.http_cidr_blocks 
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # "-1" represents all protocols
    cidr_blocks = var.outbound_didr_blocks
  }
}

output "security_group_id" {
  value=aws_security_group.my_group_1.id
}


# key-pair creation
resource "tls_private_key" "my-privatekey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "my-privatekey" {
  value=tls_private_key.my-privatekey
  sensitive=true
}

resource "aws_key_pair" "generated_key" {
  key_name   = "my_key_1"
  public_key = tls_private_key.my-privatekey.public_key_openssh
}

output "generated_key" {
  value=aws_key_pair.generated_key
}



# instance for mysql standalone
resource "aws_instance" "mysql_standalone" {
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=aws_key_pair.generated_key.key_name
  # script for standalone setup
  user_data = <<-EOF
      #!/bin/bash

      sudo apt-get update -y
      sudo apt-get upgrade -y

      # install mysql server
      sudo apt-get install mysql-server -y
      sudo apt-get install unzip -y
      sudo apt-get install sysbench -y
      sudo apt-get install git -y

      # install sakila
      cd tmp
      wget http://downloads.mysql.com/docs/sakila-db.zip
      unzip sakila-db.zip
      cd ..
      mysql -e "SOURCE /tmp/sakila-db/sakila-schema.sql;"
      mysql -e "SOURCE /tmp/sakila-db/sakila-data.sql;"

      # user to run benchmarks
      mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY '123';"
      mysql -e "GRANT ALL PRIVILEGES on sakila.* TO 'admin'@'localhost';"

      # standalone results
      sysbench --db-driver=mysql --mysql-db=sakila --mysql-user=admin --mysql_password=123 --table-size=50000 --tables=10 /usr/share/sysbench/oltp_read_write.lua prepare
      sysbench --db-driver=mysql --mysql-db=sakila --mysql-user=admin --mysql_password=123 --table-size=50000 --tables=10 --threads=6 --max-time=30 /usr/share/sysbench/oltp_read_write.lua run > mysql-standalone-results
    EOF
  lifecycle {
    create_before_destroy=true
  }

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  availability_zone=var.availability_zone

}

resource "null_resource" "delay_mysql_standalone" {
  provisioner "local-exec" {
    command = "sleep 270"  # 270 seconds or 4.5 minutes
  }
}


output "instance_id" {
    value=aws_instance.mysql_standalone.id
}

output "mysql_standalone_details" {
  value = aws_instance.mysql_standalone
}







