variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6T7OFVBEN"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="Hs7L87Gsoi+FE0tQz0y1U1luzjMSQDGkpZXfsvxM"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEOT//////////wEaDMwquLJfx6KLJY9l8iLGAaydCkx5RbECGnfTJQaVmrdDt5EMKASe9q0wJQM8TplDFPqqnpJVi/XUjEYkSKBUR2G1CTZdpjz++zfpy2R+ni0y47LSTFeTaInF/YJNaWuLqj3GpQUwgiFATbH3SwAb4oUCs71xf05E+aGcBEcNQ4CZvC2wIx0l26k8QFLRCfd2WlzobOdiBs7Xvt7ELZKDxl+enZP6az5Zf4XYL5BJWr/wH9h10PmHR8zpjzhiFtJiKjUG8+xtStQGnVCuF+kt3NNdttYwMCiv1a+rBjItZ4HPAEvgH8+GXQJ1wh1ozXbIuo2w5uu6ROfHuPSGCi5RfxlWdRGyQxFXP5lT"
}


# security group configuration
variable "security_group_name" {
    description="security group name"
    type=string
    default="my_group_1"
}

variable "ssh_cidr_blocks" {
    description="what traffic is allowed"
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




