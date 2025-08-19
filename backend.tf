# store the terraform state file in s3 and lock with dynamodb

terraform {
  backend "s3" {
    bucket         = "inno-terraform-remote-state"
    key            = "terraform-module/webapp/terraform.tfstate"
    region         = "us-east-1"
    profile        = "dev"
    dynamodb_table = "terraform-state-lock"

  }
}