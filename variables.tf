variable "aws_region" {
    description="AWS region where we want to create reessource"
    type=string
    default="us-east-1"
}

# Credentials *****NEEDS TO CHANGE EVRYTIME WE RUN SESSION*****
variable "aws_access_key_id" {
    description="aws_access_key_id"
    type=string
    default="AKIATWQRHF25U63XMZEB"       # COPY PASTE from aws academy cli
}

variable "aws_secret_access_key" {
    description="aws_secret_access_key"
    type=string
    default="WCwQi7ar3FlPA9vvzfsuU9bC9nXAbbVui/qulKBJ"  # COPY PASTE from aws academy cli
}

variable "aws_session_token" {
    description="aws_session_token"
    type=string
    # COPY PASTE from aws academy cli
    default="FwoGZXIvYXdzEO///////////wEaDL36+8fIzY2j4AjMqiLGAfJjUbUS/cmTwj1ijebC6Q1EEtUJR5DKQ0lJNEBIUwblpWakZxgRlhKlbzLLeXiht0XdznhDquyV53Uym6q5HzVGM09XlZuvYQFReaUn545OQkHlXP3hll2bL4u83RNeiUBRWSt+kS74b9ANkoN11HzbKfpIOAMFenbErX/2qC6684MkIK4Igj1B/gbiBSuhZwQ2u61j9gKQp+tGTH6qpC83vPHyyFK8K4+nP2yoLXR2cjE2R1hTKylBrHDT3Oq96b7pVRkGUCjlwaKsBjItcO3Qau5Y6gE4pKczYi83o1QQU27589y5Gc++NSk7duXxDXgcZmTW++UNc6dc"
}


# *********** IP NEED TO CHANGE PUT NULL in value IF FIRST TIME RUNNING main.tf NEED TO COPY AND PASTE VALUES FROM TERMINAL **************
variable "master_private_ip" {
    description="master ip"
    type=string
    default="172.31.89.131"   # COPY PASTE from terminal
}

variable "slave1_private_ip" {
    description="slave 1 ip"
    type=string
    default="172.31.82.240"  # COPY PASTE from terminal
} 

variable "slave2_private_ip" {
    description="slave 2 ip"
    type=string
    default="172.31.88.227" # COPY PASTE from terminal
}

variable "slave3_private_ip" {
    description="slave 3 ip"
    type=string
    default="172.31.94.184"  # COPY PASTE from terminal
}

variable "gatekeeper_private_ip" {
    description="security group name"
    type=string
    default="172.31.85.181"  # COPY PASTE MANUALLY FROM ACCOUNT PREVENT SECURITY GROUP ERROR
}


# ************** KEY USED ON PROXY MACHINE NEEDS TO BE NULL IF FIRST TIME RUNNING main.tf ******************
# ************** AFTER MANUAL CREATION COPY AND PASTE THE KEYNAME HERE **********************
variable "proxy_key_name" {
    description="security group name"
    type=string
    default="tmp1"   # COPY PASTE from aws account in key pair section
}


# security group names
variable "security_group_name" {
    description="security group name"
    type=string
    default="my_group_1"
}

variable "proxy_group_name" {
    description="proxy security group"
    type=string
    default="my_proxy"
}

variable "trustedhost_group_name" {
    description="trustedhost security group"
    type=string
    default="trustedhost_group_1"
}

# ssh_cidr_blocks
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

variable "protocol" {
    description="protocol"
    type=string
    default="-1" 
}

variable "ipv6_cidr_blocks" {
    description="ipv6_cidr_blocks"
    type=list(string)
    default=["::/0"] 
}

variable "tcp_protocol" {
    description="tcp protocol"
    type=string
    default="tcp" 
}

variable "ssh_protocol" {
    description="ssh protocol"
    type=string
    default="tcp" 
}


# instance configuration
variable "ami_id" {
    description="id of the AMI"
    type=string
    default="ami-0c7217cdde317cfec"
}

variable "instance_type" {
    description="the instance type of the image"
    type=string
    default="t2.micro"
}

variable "large" {
    description="the instance type of the image of large"
    type=string
    default="t2.large"
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






