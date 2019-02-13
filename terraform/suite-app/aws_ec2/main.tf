#-------------------------------
# AWS Provider
#-------------------------------
provider "aws" {
  region  = "${var.aws_region}"
  version = "~> 1.57"
}

#-------------------------------
# S3 Remote State
# Use S3 Bucket in Singapore region for all TF state file
#-------------------------------
terraform {
  backend "s3" {
    bucket = "suite-terraform"
    key    = "suite-ec2.tfstate"
    region = "ap-southeast-1"
  }
}

#-------------------------------
# Get the meta data from a remote backend
#-------------------------------
data "terraform_remote_state" "vpc" {
  backend    = "s3"
  workspace  = "${terraform.workspace}"

  config {
    bucket = "suite-terraform"
    key    = "suite-vpc.tfstate"
    region = "ap-southeast-1"
  }
}
