variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC65SDXL56Z"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="XRiya2NWnWmJQUD5kTQIQgDrlFbXrLQcmwSkIdkJ"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEAEaDDI366jQbUCTLm+qMyLGAWh0OiL4BSXbL4+Xu/uiKSaXkKWX3hAKUwb47deEA9+69w62uV13n3cg0GZq9GBIQtKQONHvsAJ9WYtudtbukIScJkZt9y4DapmrBj4mJPCPXtpnQitypzzOPSUEgJfebXQvhk160nVSP5qG6S/ZOd/XOpYfrqY/gEgbCwuU8JmnUNcNtQzy+r3qCnmDn0j6Bo9r0KEZdOHbFjyL+aXQ3H0e5pJ0WoGEmgAa4k6otERISheU2Y+hYlJhG8fRS4Az8e35TGmvfCirlu6rBjIt8NGMcSXMjeqcPxcmqvwnjYQrqKQCYMtAS2/jp1K79jqXBW+yRM/Mr7tLNh9i"
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






