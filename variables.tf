variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC677PRMGA5"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="yU88TX36DSjahx5XF3tFOoXaV9jdAnxR6pPthqz8"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEEYaDL6it1uLQTbIb+ejdiLGAUiI+vRQ3+FZh0BbfOft4MeSbRY8y3tJqh7acfyIUn/Jq6HdB5srSe8/xhJ52OxOBwC4uug2OtpGlfVVHGz3A85CUHlCUV7lalV7EycSWajJ/QyD19Q6MG6429iq91v13LYO5rN7mQKeE5CSvc0yccqd3MGd+pcfbj78Od2fs74qqlAuxgdKFeJVmmySjjth81/5j6lQ7J4o+HpbCY5iNJZXBBYwvP4+/coQqxkstON43H8PaSObSPo9LEnN+GYqyGYpKYWudSjrmMWrBjItbO5hpH6FrTgK6mwNLuVKM8j+GiCEeacMohEHLQ1g6wDNfMSpnt+Kl6RoRfkG"
}


# security group configuration
variable "security_group_name" {
    description="security group name"
    type=string
    default="my_group_1"
}

variable "ssh_cidr_blocks" {
    description="allow ssh"
    type=list(string)
    default=["0.0.0.0/0"] # anywhere
}

variable "http_cidr_blocks" {
    description="allow http"
    type=list(string)
    default=["0.0.0.0/0"] # anywhere
}

variable "outbound_didr_blocks" {
    description="allows all"
    type=list(string)
    default=["0.0.0.0/0"] # anywhere
}   


# instance configuration
variable "ami_id" {
    description="id of the AMI"
    type=string
    default="ami-0fc5d935ebf8bc3bc"
}

variable "instance_type" {
    description="the instance type of the image"
    type=string
    default="t2.micro"
}

variable "volume_type" {
    description="the root volume type in Configurate storage"
    type=string
    default="gp2"
}

variable "volume_size" {
    description="the volume size in GiB of the root volume"
    type=number
    default=8
}

variable "availability_zone" {
    description="the availability zone of the region"
    type=string
    default="us-east-1a"
}






