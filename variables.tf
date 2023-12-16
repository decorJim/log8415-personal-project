variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6W3KBIQ2F"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="Cvz08YYgpMDVAmQ5hugP3V2IZPXZf5EJh4BRfihK"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEBwaDL2U/QUAbfP8mkEBuiLGAUC7ejs9Fg7F1oP6upmaYsBYOmx2mBy66M/8lWf89J5Qek9IqA2Qi4HfaXk+0EsY4cCshkzsrLjF+raiHlZ1EvgRiY4rn6/FrHtBRlLhE9WqKx5g6PT8l6g4GKV3cbyQPHXcfobM58wdx11wxaDN65QbYJ/t1nTILPVCKN2nwytnI8jNthYspBxVZGxiqpKnWz6NNJhEGN/q14Nkokc/yD00DoFLvf4jkxv3bzZ0G8q+QTCIw7lNKOCTYqQn770e98iKpZijIyiAjPSrBjIt3b8EdF3I0lRsnMM0VNwecfU+C1Hb6JJBMNbKYYpT/XUOt0Ofy96ICQT68bV/"
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






