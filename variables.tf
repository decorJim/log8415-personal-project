variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6W7ZYUZAM"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="MHn/CUckzZEu7ZsBHyGo1K0Gu5Q1juOLBBRUixmu"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzELn//////////wEaDJNTqVeF8/Xj48U42yLGAXLpU7XO5w2bnp3BqXZNZ6p1fM0Hw4RNojT+E8VayJRRiECOYWQOkUAmi7B7agZOcFwA04IX75GSfMapuuhTVHnn3Hsk4adwdqEH3V/JuSR3F01cioP7wVwXuEC+Mzv3U4aA0amADBvTOzy1ezfn928iFZ9dhwXnRlICLWciFM1f4EFngXO5mMT4/VDVKd8GQaMdiYpcWLPmZiH9uogn++bzJFGqA4Jvt00k+8ki8q454dybVkRlR1Ao/KCeAndXj8dh9hHXqyip5ZasBjItnohPxwV7Zc4FCKSI/B8rPG/OfgGLSDrUJsmEML2NMBUUNJtoeqEVxekPeasB"
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






