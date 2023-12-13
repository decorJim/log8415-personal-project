variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC67E5E765P"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="Eg5keLnBkBGH9v+UlKygmoPeaYuz9wVqUiLf4NUa"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzENT//////////wEaDA/dIgOzQ1uD8oV3NCLGASem7bFKJWQ1GEkwbdWynF2Q0z/I78Vt0qTLcntYY0AxGkECHUVyYLiqdff9rA3QlrWqAQjYWqQSU6H3RYH2NB5d4GKwPBibFBv8GR5cEq13AVmD1Hi5mMqXtYB40UMT5uOlVZ9zzYcBxUdzUYZw4TRw/4k5OQdM+m+SR3sWguYS/j9owrVCpUHWmiADxhYgPiDCMfKmNPh33qpto9vvgzsyXHhpwDinVvN0nIsmuufrbBESwWtOEeGC9weFgKg2a0bmkO/zTCifouSrBjIt+OnKlfZP+xVHoFMcpLftNBwxbIAld1zIUvqIgt8x5vUuKcDa7eg2nb9ezXki"
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






