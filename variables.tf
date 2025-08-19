# environment variables
variable "region" {}
variable "project_name" {}
variable "environment" {}

# vpc variables
variable "default_cidr" {}
variable "vpc_cidr" {}
variable "public_subnet_az1a_cidr" {}
variable "public_subnet_az1b_cidr" {}
variable "private_app_subnet_az1a_cidr" {}
variable "private_app_subnet_az1b_cidr" {}
variable "private_data_subnet_az1a_cidr" {}
variable "private_data_subnet_az1b_cidr" {}

# nat-gateway variables
variable "internet_gateway" {}
variable "public_subnet_az1a_id" {}
variable "public_subnet_az1b_id" {}
variable "private_app_subnet_az1a_id" {}
variable "private_app_subnet_az1b_id" {}
variable "private_data_subnet_az1a_id" {}
variable "private_data_subnet_az1b_id" {}