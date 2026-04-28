variable "project_name" {}

variable "instance_name" {
  description = "EC2 instance name"
}

variable "subnet_id" {}
variable "is_public" {}
variable "vpc_id" {}

variable "security_group_name" {
  description = "Base name for SG"
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
variable "key_name" {
  type = string
}
variable "instance_count" {
  type = number
}

variable "root_volume_size" {
  type = number
}

variable "associate_eip" {
  description = "Attach Elastic IP or not"
  type        = bool
  default     = false
}

variable "eip_name" {
  description = "Elastic IP name"
  type        = string
  default     = "ec2-eip"
}
variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
  default     = {}
}