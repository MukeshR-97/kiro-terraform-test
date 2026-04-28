locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "terraform"
  }
}



module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs

  enable_nat_gateway = var.enable_nat_gateway
}

module "ec2" {
  source = "./modules/ec2"

  project_name  = var.project_name
  instance_name = var.instance_name

  subnet_id = var.ec2_subnet_type == "public" ? module.vpc.public_subnet_ids[0] : module.vpc.private_subnet_ids[0]

  is_public = var.ec2_subnet_type == "public"

  vpc_id = module.vpc.vpc_id

  security_group_name = var.security_group_name

  ingress_rules = var.ingress_rules
  ami_id= var.ami_id
  instance_type= var.instance_type
  key_name   = var.key_name
  instance_count   = var.instance_count
  root_volume_size = var.root_volume_size
  associate_eip = var.associate_eip
  eip_name      = var.eip_name
  common_tags = local.common_tags
}

module "keypair" {
  source = "./modules/keypair"

 key_name = var.key_name
}

