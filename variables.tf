variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}


# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="ASIAXZSEYFC6XRTCSFWL"
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="OkI6i1BOGVBMGbFcWAsBqGP64EzXPQaDEgeVPdl7"
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    default="FwoGZXIvYXdzEGAaDHitOm/mJz81Atvm2CLGAUCiBWHkDf07MtjGuZ8iwkN38n0JHnLdLIuMXzqoLNv3J8xeROsHrH9udecoku2m42dmaia5+TslFFvmLltieUNoXuERgzdK1FNOHyFUfJTBsJef0QSsM28FjM0wKruRUbhJd8HnoEBcOUBfn7j13CvkKt3E9P7xKPDtsRawntKfNEDfxRM7vJS3/+npof1z7RwcZZRj4aA167N9Frorhz+Xu697AW2NzjZ0dt9EsixiNMTeBaZLjQpAi5Snq53Xgnt+TB+Q9ijxjYOsBjItaYFPRjod5ASg4tjb44tCID5nDHPUvmsg9xadLab7b6mhVcE/deXkqM2lWleY"
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






