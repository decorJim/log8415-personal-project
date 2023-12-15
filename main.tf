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



# # instance for mysql standalone
# resource "aws_instance" "mysql_standalone" {
#   ami = var.ami_id
#   instance_type=var.instance_type
#   vpc_security_group_ids=[aws_security_group.my_group_1.id]
#   key_name=aws_key_pair.generated_key.key_name
#   # script for standalone setup
#   user_data = file("${path.module}/sql_standalone.sh")
     
#   lifecycle {
#     create_before_destroy=true
#   }

#   root_block_device {
#     volume_type=var.volume_type
#     volume_size=var.volume_size
#   }
  
#   availability_zone=var.availability_zone

# }

# resource "null_resource" "delay_mysql_standalone" {
#   depends_on=[aws_instance.mysql_standalone]
#   provisioner "local-exec" {
#     command = "sleep 186"  # 3.10 min
#   }
# }


# output "instance_id" {
#   depends_on=[null_resource.delay_mysql_standalone]
#   value=aws_instance.mysql_standalone.id
# }

# output "mysql_standalone_details" {
#   depends_on=[null_resource.delay_mysql_standalone]
#   value = aws_instance.mysql_standalone
# }

############################################ mySQL cluster #################################################

# master instance
resource "aws_instance" "master_node" {
#  depends_on=[null_resource.delay_mysql_standalone]
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=aws_key_pair.generated_key.key_name
  # script for master
  user_data = file("${path.module}/sql_cluster_master.sh")
  lifecycle {
    create_before_destroy=true
  }

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  availability_zone=var.availability_zone
}

# slave nodes
resource "aws_instance" "slaves_node" {
#  depends_on=[null_resource.delay_mysql_standalone]
  ami = var.ami_id
  instance_type=var.instance_type
  vpc_security_group_ids=[aws_security_group.my_group_1.id]
  key_name=aws_key_pair.generated_key.key_name
  count         = 3
  user_data = file("${path.module}/sql_cluster_slave.sh")
  lifecycle {
    create_before_destroy=true
  }

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }
  
  availability_zone=var.availability_zone
}

output "master_ip" {
  depends_on=[aws_instance.master_node]
  value=aws_instance.master_node.public_ip
}

resource "null_resource" "ec2_cluster_timeout" {
  depends_on=[
    aws_instance.master_node,
    aws_instance.slaves_node
  ]
  provisioner "local-exec" {
    command = "sleep 180"  # sleep for 2 minutes
  }
}

resource "null_resource" "wait_for_master_instance" {
  depends_on = [
    null_resource.ec2_cluster_timeout
  ]

  # Use local-exec provisioner to run a command
  provisioner "local-exec" {
    command = <<-EOT
      python3 ${path.module}/sendToMaster.py \
        --ipurl=${aws_instance.master_node.public_ip} \
        --ip1=${aws_instance.master_node.private_ip} \
        --ip2=${aws_instance.slaves_node[0].private_ip} \
        --ip3=${aws_instance.slaves_node[1].private_ip} \
        --ip4=${aws_instance.slaves_node[2].private_ip} 
    EOT
  }
}

resource "null_resource" "slave_1_setup" {
  depends_on = [
    null_resource.wait_for_master_instance
  ]

  # Use local-exec provisioner to run a command
  provisioner "local-exec" {
    command = <<-EOT
      python3 ${path.module}/sendToSlaves.py \
        --ipurl=${aws_instance.slaves_node[0].public_ip} \
        --ip1=${aws_instance.master_node.private_ip}
    EOT
  }
}

resource "null_resource" "slave_2_setup" {
  depends_on = [
    null_resource.wait_for_master_instance
  ]

  # Use local-exec provisioner to run a command
  provisioner "local-exec" {
    command = <<-EOT
      python3 ${path.module}/sendToSlaves.py \
        --ipurl=${aws_instance.slaves_node[1].public_ip} \
        --ip1=${aws_instance.master_node.private_ip}
    EOT
  }
}

resource "null_resource" "slave_3_setup" {
  depends_on = [
    null_resource.wait_for_master_instance
  ]

  # Use local-exec provisioner to run a command
  provisioner "local-exec" {
    command = <<-EOT
      python3 ${path.module}/sendToSlaves.py \
        --ipurl=${aws_instance.slaves_node[2].public_ip} \
        --ip1=${aws_instance.master_node.private_ip}
    EOT
  }
}

resource "null_resource" "cluster_benchmark_activation" {
  depends_on=[
    null_resource.slave_1_setup,
    null_resource.slave_2_setup,
    null_resource.slave_3_setup
  ]

  # Use local-exec provisioner to run a command
  provisioner "local-exec" {
    command = <<-EOT
      python3 ${path.module}/cluster_benchmarks.py \
        --ipurl=${aws_instance.master_node.public_ip}
    EOT
  }
}


