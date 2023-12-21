variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC677GHH7OL"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="1mQ7Xm8iDFDl6+MW0AYSnduGfAwh5RfVkv3oLV4n"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEKT//////////wEaDODwtSjYdCrYMqvodyLGAeLA6rHUJ46p6ClsLGN5e8/tmV3F7pEvs//7GC9p5e9AWhWdvZHLqVnQJVOvTTS0FcqHBjPZrawM66kshtP8OirAu9fQpxx9B+YWatn+06uq8G+Bhcd/Tl/aYXThSN5BkcakK2NC0rGgE6xC7uyFJujQzxu35/8/VMO+B4bKXIi4MynurByKkJEEWPiy9ub8+iFOchGt5IGovJsZ5vPmC8Aajh28ZiyFsPGl0n9pGwrsZTeuJgRoT9EE5DNc+6rXB/Ci5euozSjihpKsBjItftD/guPIuma52FxPJw3Uyo8nzqNb3Utfsv/kbcJOT7t2aeMiBDwJ3Y2Is6go"
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






