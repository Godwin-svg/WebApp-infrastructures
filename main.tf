# create locals variables
locals {
  region       = var.region
  project_name = var.project_name
  environment  = var.environment
}

# create vpc module
module "vpc" {
  source                        = "git@github.com:Godwin-svg/Building-AWS-Infrastructure-with-Terraform-Modules.git//vpc"
  region                        = local.region
  project_name                  = local.project_name
  environment                   = local.environment
  default_cidr                  = var.default_cidr
  vpc_cidr                      = var.vpc_cidr
  public_subnet_az1a_cidr       = var.public_subnet_az1a_cidr
  public_subnet_az1b_cidr       = var.public_subnet_az1b_cidr
  private_app_subnet_az1a_cidr  = var.private_app_subnet_az1a_cidr
  private_app_subnet_az1b_cidr  = var.private_app_subnet_az1b_cidr
  private_data_subnet_az1a_cidr = var.private_data_subnet_az1a_cidr
  private_data_subnet_az1b_cidr = var.private_data_subnet_az1b_cidr

}

# # create nat-gateway module
module "nat-gateway" {
  source                      = "git@github.com:Godwin-svg/Building-AWS-Infrastructure-with-Terraform-Modules.git//nat-gateway"
  region                      = local.region
  project_name                = local.project_name
  environment                 = local.environment
  default_cidr                = var.default_cidr
  vpc_id                      = module.vpc.vpc_id
  internet_gateway            = module.vpc.internet_gateway
  public_subnet_az1a_id       = module.vpc.public_subnet_az1a_id
  public_subnet_az1b_id       = module.vpc.public_subnet_az1b_id
  private_app_subnet_az1a_id  = module.vpc.private_app_subnet_az1a_id
  private_app_subnet_az1b_id  = module.vpc.private_app_subnet_az1b_id
  private_data_subnet_az1a_id = module.vpc.private_data_subnet_az1a_id
  private_data_subnet_az1b_id = module.vpc.private_data_subnet_az1b_id

}


# create security group module 
module "security_group" {
  source       = "git@github.com:Godwin-svg/Building-AWS-Infrastructure-with-Terraform-Modules.git//security-group"
  project_name = local.project_name
  environment  = local.environment
  default_cidr = var.default_cidr
  vpc_id       = module.vpc.vpc_id
  ssh_ip       = var.ssh_ip

}