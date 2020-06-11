provider "aws" {
  region     = var.aws_region
}

module "vpc" {
  source              = "./modules/vpc"
  name_prefix         = terraform.workspace

  vpc_cidr            = "10.0.0.0/16"
  external_net_cidr   = "10.0.10.0/24"
  internal_net_cidr   = "10.0.138.0/24"
  management_net_cidr = "10.0.30.0/24"
}

module "jumpbox" {
  source           = "./modules/linux-jumpbox"
  name_prefix      = terraform.workspace

  aws_region       = var.aws_region
  key_pair         = var.key_pair
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.mgmt_subnet_id
  mgmt_private_ip  = "10.0.30.100"
}

module "f5_ltm_dev" {
  source             = "./modules/f5-bigip"
  aws_region         = var.aws_region
  key_pair           = var.key_pair
  name_prefix        = "iaacdemo-dev"

  vpc_id             = module.vpc.vpc_id
  mgmt_subnet_id     = module.vpc.mgmt_subnet_id
  external_subnet_id = module.vpc.external_subnet_id
  internal_subnet_id = module.vpc.internal_subnet_id

  external_ips       = ["10.0.10.101"]
  internal_self_ip   = "10.0.138.101"
  management_ip      = "10.0.30.101"
  
  bigiq_secret_name = var.bigiq_secret_name

  default_tags       = {
      id = "devltm01"
      environment = "dev"
  }
}

module "f5_ltm_prd" {
  source             = "./modules/f5-bigip"
  aws_region         = var.aws_region
  key_pair           = var.key_pair
  name_prefix        = "iaacdemo-prd"

  vpc_id             = module.vpc.vpc_id
  mgmt_subnet_id     = module.vpc.mgmt_subnet_id
  external_subnet_id = module.vpc.external_subnet_id
  internal_subnet_id = module.vpc.internal_subnet_id

  external_ips       = ["10.0.10.106"]
  internal_self_ip   = "10.0.138.102"
  management_ip      = "10.0.30.102"

  bigiq_secret_name = var.bigiq_secret_name

  default_tags       = {
      id = "prdltm01"
      environment = "prd"
  }
}