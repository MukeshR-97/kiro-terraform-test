
variable "vpc_cidr" {}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "enable_nat_gateway" {
  type = bool
}

variable "ec2_subnet_type" {
  description = "public or private"
}

variable "instance_name" {}
variable "security_group_name" {}

variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}


variable "key_name" {
  type = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_count" {
  type    = number
  default = 1
}

variable "root_volume_size" {
  type    = number
  default = 8
}

variable "associate_eip" {
  default = false
}
variable "eip_name" {
  default = ""
}
variable "owner" {
  default = ""
}
variable "environment" {
  default = "dev"
}
