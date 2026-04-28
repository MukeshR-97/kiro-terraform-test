variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type = bool
}
variable "azs" {
  description = "Availability Zones"
  type        = list(string)

  default = ["ap-south-2a", "ap-south-2b"]
}