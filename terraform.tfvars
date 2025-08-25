# vpc variables
region                        = "us-east-1"
project_name                  = "webapp"
environment                   = "dev"
default_cidr                  = "0.0.0.0/0"
vpc_cidr                      = "10.0.0.0/16"
public_subnet_az1a_cidr       = "10.0.0.0/24"
public_subnet_az1b_cidr       = "10.0.1.0/24"
private_app_subnet_az1a_cidr  = "10.0.2.0/24"
private_app_subnet_az1b_cidr  = "10.0.3.0/24"
private_data_subnet_az1a_cidr = "10.0.4.0/24"
private_data_subnet_az1b_cidr = "10.0.5.0/24"

# security group variable
ssh_ip = ["101.115.228.122/32"]

# variable for rds
database_snapshot_identifier = "wordpress-rds-snapshot"
database_instance_class      = "db.t3.micro"
database_instance_identifier = "wordpress-rds"
multi_az_deployment          = "false"


# acm variables
domain_name       = "godwintechservices.com"
alternative_names = "*.godwintechservices.com"

# alb variables 
target_type = "ip"

# s3 variables
env_file_bucket_name = "inno-ecs-env-file-bucket"
env_file_name        = "rentzone.env"