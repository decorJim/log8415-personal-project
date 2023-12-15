variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC67YBQ5IU4"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="PWlwpsBN4oTrbaup2h7szuJQWIMufECpGehqS5D8"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEAMaDMmYgHgLG/UGP/Vp6CLGAcF0Q7czWXqAWoqgzC4zKL1k4OCEm3YxwdNht5LslXYLwGDxjXoqg733ZJIm+wUVHjkbzwwOadB/4APH3pHMhGbweZkCXWpKQbIlHfzaA/qJMB3/nVYTnYu16l/VzDxjaHixYwFKY0gE0ZqkU6T5gLJ0n0+16bF4NiFJC1ffaVvZv/WRsRJQAVkiOmfhj2mfzkjGzZkWhZR0RBqZlBXfUe5+CRNuTbJzBD1kfq/7ng1Nw67m/rKEnFayiFlpB+HU1xjXIM9KyyiV0u6rBjItlVEZWsrs2hBvNO8DkqQ1fdneTb0Mf/lRK+KSUncBZbz9xUJjFul493BhRJ15"
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






