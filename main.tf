# credentials
provider "aws" {
  region = var.aws_region  # Replace with your AWS region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token = var.aws_session_token
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
    protocol    = var.protocol  # "-1" represents all protocols
    cidr_blocks = var.outbound_didr_blocks
    ipv6_cidr_blocks = var.ipv6_cidr_blocks
  }

  vpc_id=data.aws_vpcs.all_vpcs.ids[0]
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

output "mysql_standalone_details" {
  value = aws_instance.mysql_standalone
}

############################################ mySQL cluster #################################################

# master instance
resource "aws_instance" "master_node" {
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=aws_key_pair.generated_key.key_name
  # script for master
  user_data = file("${path.module}/master_setup.sh")
  lifecycle {
    create_before_destroy=true
  }

  private_ip="172.31.20.182"

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
  key_name=aws_key_pair.generated_key.key_name
  user_data = file("${path.module}/slave_setup.sh")
  lifecycle {
    create_before_destroy=true
  }

  private_ip="172.31.17.145"

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
  key_name=aws_key_pair.generated_key.key_name
  user_data = file("${path.module}/slave_setup.sh")
  lifecycle {
    create_before_destroy=true
  }

  private_ip="172.31.22.69"

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
  key_name=aws_key_pair.generated_key.key_name
  user_data = file("${path.module}/slave_setup.sh")
  lifecycle {
    create_before_destroy=true
  }

  private_ip="172.31.18.246"

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

output "master_ip" {
  depends_on=[aws_instance.master_node]
  value=aws_instance.master_node.public_ip
}


# BENCHMARK PART NEEDS TO BE DONE MANUALLY CHECK INSTRUCTIONS IN README
# resource "null_resource" "cluster_benchmark_activation" {
#   depends_on=[
#     null_resource.slave_1_setup,
#     null_resource.slave_2_setup,
#     null_resource.slave_3_setup
#   ]

#   # Use local-exec provisioner to run a command
#   provisioner "local-exec" {
#     command = <<-EOT
#       python3 ${path.module}/cluster_benchmarks.py \
#         --ipurl=${aws_instance.master_node.public_ip}
#     EOT
#   }
# }





