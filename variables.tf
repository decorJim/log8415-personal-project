variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC65WJZQNA5"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="nr1LDMWwiRhVzZMWnT84+6+AwYJ7p++85+Ay3vEH"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEPz//////////wEaDPbN2E9ySDxy0yhJvSLGAfztsRniCSYhXAeTZYHtTFxYNt2gFZBSRW/GNtzaXZgdPzoDrYSQb/cEKcM7HyPTz9Xsk8Zcy4inzG8yUxSGM1S6Zl13zI3gGVsbfwwDIhflpTOdCVBOPKOAbqt6+CAT1VvS82NGz7d85ADM+xeKxz9Zm+Wr+jH1yjXlDjO/F4L6M3H0faZFe02pZh9bT3JC/z5wHRlLj2i+/0Q7g43OZ2MK6Z+Jl7u+R3Yfcy6ChgbgTq88uwvSDu/EhnyFG/zKwRV4VWrbIijb+7SrBjIt8+CGD+rloE/5kh+0NBAx4LYIx7ZEg3sy8fuge+f0PL9vqYi6foxWKjWy/TaO"
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




