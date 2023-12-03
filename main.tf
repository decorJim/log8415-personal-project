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

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks  # Replace with your desired CIDR blocks
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

  lifecycle {
    create_before_destroy=true
  }

  root_block_device {
    volume_type=var.volume_type
    volume_size=var.volume_size
  }

  availability_zone=var.availability_zone

}


output "instance_id" {
    value=aws_instance.mysql_standalone.id
}

output "mysql_standalone_details" {
  value = aws_instance.mysql_standalone
}







