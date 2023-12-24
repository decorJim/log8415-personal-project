variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6XZV7NY62"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="vuTNZRozVcUy9beYalqn1MdX2DY3w+8WvXyBntR/"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEN7//////////wEaDHVGJhmMHpVsfqkn3CLGAUrbJiGTX6bxfAMGieXLeUEAKkX5Xjaz74ifUwu9DHoNspeAbFnOlA6pFwcdyqXP0e+E5fF90Xa/rg2kSeWtJctefjpHa4OPvdciJ4lPtfoqO3eLlkJgoYoP8zoqPZymcxTjajVYWfrasXzsOyuPP8V+Bx+LLkNHr9Xa9CRSmEZCkU9SoYgBpKoM0YN0bxU7HSY6v2V07V14Yhzxd6rM71Y/JKUDeYUV39JUCS+ThheEVNnwoqZGUZeOYR7CPlvY2AnfjmPfzCjf8J6sBjItNL0jGNHfUc8qsg4B0XNkuDxxmTSqiIbWd7vYYXVw9ReMiw3lYo37TdkPuu6T"
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

variable "protocol" {
    description="protocol"
    type=string
    default="-1" 
}

variable "ipv6_cidr_blocks" {
    description="ipv6_cidr_blocks"
    type=list(string)
    default=["::/0"] 
}


# instance configuration
variable "ami_id" {
    description="id of the AMI"
    type=string
    default="ami-0c7217cdde317cfec"
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






