variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6RTAO4OPY"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="dr91CCbjah2Yv2ydK1NU2mZjB6CihPtA5zgMiYKR"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEFwaDM9kg0w7MipDXPO7hiLGAWFXmiZUINrkEo/f1xl154CzsKOf4wEK4Is23BbRB3WtrbLmSG7zl5sIoyaKoVP+xCdS7OoKOnZq6+aIwys2S/s0KUoIpWbzdDHrqXOHi1aQT+Z2fjuWMApQh1J2rBx+NW2PPAJCSCH0kvOp2Q9jES8j2vsmI0sNjpsdHlXgk0q2MOsCSg9y+CoPOpjuLSv8nVkUcOLcEXRC36fnRkgu9lhMA+RCKqOtTVY0UEmU0sYqaHEo/uW5hCJYVmw0MSREQI4rz702UyjhmIKsBjItWRy/O1aZ+Dlkr/HH+4eS48Tl4UhZvevYF/JoLlNhV+BBpqZg63LKe8UuwK2h"
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






