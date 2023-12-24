variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6664LAMGV"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="P9O3XQCneuYnrRftf9eeIRz8E+DOMNcpP/cUoQmC"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzENn//////////wEaDIJzwaM6lqDxBYo4fCLGAczfodJr9qiLgB2x3moCSqDeOfu+4nk1CppqeU4Zdm0CQ3Rfa8MmlLetYOOYWh84p8tIM/uIRt+ftz8engGqYuf8Gvy+qEgYxY+Uqk1FNWU33j7OM6qK4J9/yllBGOUd3TujfCLAZTWuhwOu+TN3N6X0TLxoCuNgmHSsXYZHOKgQMa6WPK/OLDFSemVLFWtqEQidAAH14Al5mG/V1iDP8LE5wUNQVq0uW8R9bR5wXg766xeris/wZOUQ194OvRGYO1eZGZ/1oiih4Z2sBjItzvyrKyh8yBReu6ViB13rb0KMT9wALSzNensBE1CeWV44ye9NkAdH06fedhju"
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






