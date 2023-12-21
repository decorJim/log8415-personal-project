variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6XE3QZUPC"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="L508gA3Aw4snVizYXqhmnFeymk3uscbYSfKaerUP"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEJX//////////wEaDJEvbmQrLiyMM79OKiLGARHiAW9W4lt0+Fp7pg7SiatY7neLzvhNBOqGXBVzWWzmbE1ujg6ES40jVZV0IK/Ipi8mXs/w/+3SWIkekbiPxqoiXcel8p2dcnVJ2ZxKPILEVB4CtVItZxJDf/GyF50iQDF+q6ccf96LtxZYCrxPOR9P/cMMVE+mFE/owNPNGAL5yBVMYQZFJ0sK1fbfXkIbHlXufTN+WZ1SLvcduW05GS/HF+ZWPdxeaNh+p/t6tOOhoXVdwgGiJKBS2R+np5bXAPBMop02fCiI5I6sBjItXG5lkMkPSrClVugokoW7ZV1oP/8mipzpn3VWF3X6fcobn1f2SFZRIFQuEmGg"
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






