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


data "aws_availability_zones" "available_zone" {}
# launch rds instance
module "rds" {
  source                       = "git@github.com:Godwin-svg/Building-AWS-Infrastructure-with-Terraform-Modules.git//rds"
  project_name                 = local.project_name
  environment                  = local.environment
  private_data_subnet_az1a_id  = module.vpc.private_data_subnet_az1a_id
  private_data_subnet_az1b_id  = module.vpc.private_data_subnet_az1b_id
  database_snapshot_identifier = var.database_snapshot_identifier
  database_instance_class      = var.database_instance_class
  availability_zone_1          = data.aws_availability_zones.available_zone.names[0]
  database_instance_identifier = var.database_instance_identifier
  multi_az_deployment          = var.multi_az_deployment
  database_security_group_id   = module.security_group.database_security_group_id

}

# request ssl certificate
module "ssl_certificate" {
  source            = "git@github.com:Godwin-svg/Building-AWS-Infrastructure-with-Terraform-Modules.git//acm"
  domain_name       = var.domain_name
  alternative_names = var.alternative_names

}

# launch alb  
module "alb" {
  source                = "git@github.com:Godwin-svg/Building-AWS-Infrastructure-with-Terraform-Modules.git//alb"
  project_name          = local.project_name
  environment           = local.environment
  alb_security_group_id = module.security_group.alb_security_group_id
  public_subnet_az1a_id = module.vpc.public_subnet_az1a_id
  public_subnet_az1b_id = module.vpc.public_subnet_az1b_id
  target_type           = var.target_type
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = module.ssl_certificate.certificate_arn

}