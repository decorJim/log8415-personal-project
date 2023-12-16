variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6774IIPHD"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="ML3+/pnazKv0eXMBu5/7er7gisGseiHXU4eadfik"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzECwaDMFmZJ6htPuYAB1n0iLGARBLtYQyG2SJea9IFd3gxxHfSivF7dYEYooEhdBO0wG5/9Lm/nU1kHTlaRbZ5/dC/6NF/nEaDxahbGpYqKrLIc+YD72zZ+udxbgojNZNXbzRCgVzxSslIBm5Ce84LREu2z1J92Fmtco0J7Z7c5tDa2ZNDX5QZLhFjGHYPgE4xs1vZlV++2xC2BywTjmCXKYLHvWUs4HkVChQjOR2Vr2xnBdRdWuQIbTRPCAi1voZCfAmsKTH2LPS+gES4Mo26HK9yArXv7fsASid0ferBjItV7w/pYRIupS8UIDVOTtGRav072X6Y+2C7Qn9HXdR+PJjAoZvjxpJNIqh7BxH"
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

variable "mysql_cluster_cidr_blocks" {
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






