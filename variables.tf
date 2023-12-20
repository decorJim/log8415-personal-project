variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6TMZR3NYP"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="m2KcBoFNnYa3F06KAbAp2X80s0IGTajuOmu0U1Ik"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEI7//////////wEaDIVW9eS3dKjNCFKMQSLGAZGm8wg3WyXYau7rc9dpaJ+DhRckq7/BWJAlzhj4A67yFInGqLIHYfTxmuwqtNNDLpEwLnSrg44DmPnMPp7eNzqHmr8fD1Opd5kkjUwEF/bFViFdFQnn7ibW27bt9XvH3WjK1ahEz4RiDGMqsHrvMO9p8fmQBBDc9HDfwdC4kXaNZqV1R3ubPaUkzRPG8FrNnKlT4MqyH175TJ4obeRQxVBi56MHYGsAqnPSDNVG5xEyX6D++L4IADz2y8kxGv2wsvgeA0xNZSi5rI2sBjItZIWyU2TyaesmGtgoNoX6z+V0EDkmjhBVStjkFNBdPZKWXFaxLGlLKv5q80YB"
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






