variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6YLDSK2DB"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="5u3o03p4JFXOOG2gaFVFjEWl66HNjcPX8Bx0h4zu"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEBMaDMSeVilO2CVjOIs+mCLGAcSVISIfuu/Ug38x/fXwzARNBLo+NP5tJZRcFXGeLOPtiHP/iUmyuifFVPFFNR7vefmY3STVLnqa54+o9YKgRfpLhRftsFRbEjjm5h6ZfOK6Nw6v0MjqDikQ4DzYYUF/9jkkE237HDtydLJLd/vAFtR0ZHOUSVmi3m4CXpurgv8J0U32mAp5/vqI1FBZR/HU9pc3pBGLXjuEPDT0gdoPbPfgoxqCXDsqwmFqHkQ6YvNWaaNM1+pyFVX/x/pQkVWKy+FIS74tmijcpvKrBjIt1JVp9qj/gFesnMOW2J0NBYCg/uJSW/BaQtFpZ5/XeIrKUtzZKEMR7RmUSrVF"
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






