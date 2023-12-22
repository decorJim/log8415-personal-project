variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC623AM5OWA"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="3utUU8dUO5gutnvsoANFYbakBdXejyqCZht99lYU"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEL///////////wEaDHMGHRXkEi4P9Ol89CLGAXOnbKdlsIaeeFGPUGzw1RGIjYzuIgBX6ARWZ28qC/Qb8/o/MGPMyNxjTuYUZ1ix1jK+7ZQUt6uwqr7iyelpdFT2PeVlKxL8flBZhgxwt5+Ud3Lj3I+Y9bTkIHA8Qak8HLHG57dbREyZmiXIOtK6rzE3aDKNASXPnNDbFFz6xvnrh0j+GbWfBrK6JPKNf3tGoo3sesarz6mtSIuJ/srpgXjjd8OabXJ3C3gL4gp99E1aWPOsav8j0GLqe1Bp0UWaFeOK/WPZbCirhpisBjItG/SPvf7ZxXrSqtT4RUybEpOJ/nBap8H79RPRh/hGQXJGSQ2H09SlpwhveNLn"
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






