# credentials
provider "aws" {
  region = var.aws_region  # Replace with your AWS region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  #token = var.aws_session_token
}

############################################ mySQL standalone #################################################

data "aws_vpcs" "all_vpcs" {}

# Output the ID of the first VPC (if any)
output "first_vpc_id" {
  value = length(data.aws_vpcs.all_vpcs.ids) > 0 ? data.aws_vpcs.all_vpcs.ids[0] : null
}

# create security group
resource "aws_security_group" "my_group_1" {
  name        = var.security_group_name
  description = "Allow SSH inbound traffic"

   # rules
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = var.protocol
    cidr_blocks = var.ssh_cidr_blocks  
    ipv6_cidr_blocks = var.ipv6_cidr_blocks
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = var.protocol 
    cidr_blocks = var.outbound_didr_blocks
    ipv6_cidr_blocks = var.ipv6_cidr_blocks
  }

}

output "security_group_id" {
  value=aws_security_group.my_group_1.id
}


# instance for mysql standalone
resource "aws_instance" "mysql_standalone" {
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=var.proxy_key_name
  # script for standalone setup
  user_data = file("${path.module}/sql_standalone.sh")
     
  lifecycle {
    create_before_destroy=true
  }

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  tags = {
    Name = "standalone"
  }

  availability_zone=var.availability_zone

}


output "instance_id" {
  value=aws_instance.mysql_standalone.id
}

############################################ mySQL cluster #################################################

# master instance
resource "aws_instance" "master_node" {
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=var.proxy_key_name
  # script for master
  user_data = file("${path.module}/master_setup.sh")
  lifecycle {
    create_before_destroy=true
  }

  private_ip=var.master_private_ip

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  tags = {
    Name = "master"
  }

  availability_zone=var.availability_zone
}

# slave nodes
resource "aws_instance" "slave1" {
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=var.proxy_key_name
  user_data = file("${path.module}/slave_setup.sh")
  lifecycle {
    create_before_destroy=true
  }

  private_ip=var.slave1_private_ip

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  tags = {
    Name = "slave1"
  }
  
  availability_zone=var.availability_zone
}

# slave nodes
resource "aws_instance" "slave2" {
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=var.proxy_key_name
  user_data = file("${path.module}/slave_setup.sh")
  lifecycle {
    create_before_destroy=true
  }

  private_ip=var.slave2_private_ip

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  tags = {
    Name = "slave2"
  }
  
  availability_zone=var.availability_zone
}

# slave nodes
resource "aws_instance" "slave3" {
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=var.proxy_key_name
  user_data = file("${path.module}/slave_setup.sh")
  lifecycle {
    create_before_destroy=true
  }

  private_ip=var.slave3_private_ip

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  tags = {
    Name = "slave3"
  }
  
  availability_zone=var.availability_zone
}


##############################################################################

output "master_public_ip" {
  depends_on=[aws_instance.master_node]
  value=aws_instance.master_node.public_ip
}

output "master_private_ip" {
  depends_on=[aws_instance.master_node]
  value=aws_instance.master_node.private_ip
}

output "slave1_public_ip" {
  depends_on=[aws_instance.slave1]
  value=aws_instance.slave1.public_ip
}

output "slave1_private_ip" {
  depends_on=[aws_instance.slave1]
  value=aws_instance.slave1.private_ip
}

output "slave2_public_ip" {
  depends_on=[aws_instance.slave2]
  value=aws_instance.slave2.public_ip
}

output "slave2_private_ip" {
  depends_on=[aws_instance.slave2]
  value=aws_instance.slave2.private_ip
}

output "slave3_public_ip" {
  depends_on=[aws_instance.slave3]
  value=aws_instance.slave3.public_ip
}

output "slave3_private_ip" {
  depends_on=[aws_instance.slave3]
  value=aws_instance.slave3.private_ip
}


# create security group
resource "aws_security_group" "my_proxy" {
  name        = var.proxy_group_name
  description = "Allow SSH inbound traffic"

   # rules
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = var.protocol
    cidr_blocks = var.ssh_cidr_blocks  
    ipv6_cidr_blocks = var.ipv6_cidr_blocks
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = var.protocol  
    cidr_blocks = var.outbound_didr_blocks
    ipv6_cidr_blocks = var.ipv6_cidr_blocks
  }

}


# proxy
resource "aws_instance" "proxy" {
  depends_on=[
    aws_instance.master_node,
    aws_instance.slave1,
    aws_instance.slave2,
    aws_instance.slave3
  ]
  ami = var.ami_id
  instance_type=var.large
  vpc_security_group_ids=[aws_security_group.my_proxy.id] 
  key_name=var.proxy_key_name     # NEED TO CHANGE ALWAYS

  lifecycle {
    create_before_destroy=true
  }

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  user_data = file("${path.module}/proxy.sh")

  tags = {
    Name = "proxy"
  }
  
  availability_zone=var.availability_zone
}

output "proxy_public_ip" {
  depends_on=[aws_instance.proxy]
  value=aws_instance.proxy.public_ip
}



# trusted host
resource "aws_instance" "trustedhost" {
  depends_on=[
    aws_instance.proxy
  ]
  ami = var.ami_id
  instance_type=var.large
  vpc_security_group_ids=[aws_security_group.my_proxy.id]  # TO CHANGE 
  key_name=var.proxy_key_name     # NEED TO CHANGE ALWAYS

  lifecycle {
    create_before_destroy=true
  }

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  user_data = file("${path.module}/trustedhost.sh")

  tags = {
    Name = "trustedhost"
  }
  
  availability_zone=var.availability_zone
}


# gatekeeper
resource "aws_instance" "gatekeeper" {
  depends_on=[
    aws_instance.trustedhost
  ]
  ami = var.ami_id
  instance_type=var.large
  vpc_security_group_ids=[aws_security_group.my_proxy.id] 
  key_name=var.proxy_key_name     # NEED TO CHANGE ALWAYS

  lifecycle {
    create_before_destroy=true
  }

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  user_data = file("${path.module}/gatekeeper.sh")

  tags = {
    Name = "gatekeeper"
  }
  
  availability_zone=var.availability_zone
}




