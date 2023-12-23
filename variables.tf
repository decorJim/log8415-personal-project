variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6RXQPHN4U"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="eEjOKJnnEHoqAy8n2x9Qgbk2R7CxBQTRqGp+T4W2"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEMP//////////wEaDPPYD6Z07rgVeWd0cyLGAf7AF/RWbmjSWszZbcDENukDBfFO6HPL/ys8BAq8OeYMW7Y4Dnw9c6pXHGeL2KaVVIsvTsVmqZCHzsHUkKYJIBUdSE4A5Mvcmrv3r2hpWOYzbUey1HkpGPmqfH9QEmI1qFzcdC3IJlqCy5uBtqiWkCTOjKDve7czn+lhKxtPu4LuKeN4LvdKuar3pxGFfSNcliBUhb4toSG6Wvf9c76h4VBT3SMWcCFpJqH7ZWMnwsSSvtN9x/PFg7mH1JH+7Gmjkkc4qUqQlijH95isBjItpX+zIjqvQvTqP38YBXluo5iQlqtgoChuIeSEvtrZMX/1T8Gq/bRytcppd8bX"
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






