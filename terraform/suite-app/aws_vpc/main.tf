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
    key    = "suite-vpc.tfstate"
    region = "ap-southeast-1"
  }
}

#-------------------------------
# Create a VPC
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/1.37.0
#-------------------------------

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${terraform.workspace}-suite-vpc"
  cidr = "${var.vpc_cidr}"

  azs              = "${var.vpc_region_az}"
  public_subnets   = "${var.public_subnet_cidr}"
  private_subnets  = "${var.private_subnet_cidr}"
  database_subnets = "${var.database_subnet_cidr}"

  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  enable_nat_gateway   = "${var.enable_nat_gateway}"
  single_nat_gateway   = "${var.single_nat_gateway}"

  map_public_ip_on_launch = false

  // applies to all provisioned resources
  tags = {
    Project     = "ProxiSuite-Experimental"
    Environment = "${terraform.workspace}"
  }
}

#-------------------------------
# Bastion Host
#-------------------------------
resource "aws_security_group" "bastion_host_sg" {
  name        = "${terraform.workspace}-bastion-host-sg"
  description = "Security group for the Bastion Host EC2 instance"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.bastion_host_ssh_cidr_block}"
  }

  # Allow ssh to destination cidr block
  egress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "${var.private_subnet_cidr}",
      "${var.database_subnet_cidr}",
      "${var.public_subnet_cidr}",
    ]
  } 

  tags = {
    Project     = "${var.tag_project_name}"
    Environment = "${terraform.workspace}"
    noshutdown  = true
  }
}

# Create Keypair
#resource "aws_key_pair" "bastion_host_public_key" {
#  key_name   = "${terraform.workspace}-bastion-host-public-key"
#  public_key = "${file(var.bastion_host_public_key)}"
#}

# Ubuntu AMI
# TODO: Replace with hardened AMI
#data "aws_ami" "ubuntu_ami" {
#  most_recent = true
#
#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
#  }
#
#  filter {
#    name   = "virtualization-type"
#    values = ["hvm"]
#  }
#
#  owners = ["099720109477"] # Canonical
#}

# Bastion Host EC2 instance
#resource "aws_instance" "bastion_host" {
#  ami           = "${data.aws_ami.ubuntu_ami.id}"
#  instance_type = "t2.micro"
#  key_name      = "${aws_key_pair.bastion_host_public_key.key_name}"
#
#  vpc_security_group_ids = ["${aws_security_group.bastion_host_sg.id}"]
#  subnet_id              = "${module.vpc.public_subnets[0]}"
#
#  associate_public_ip_address = true
#
#  tags = {
#    Name        = "${terraform.workspace}-bastion-host-suite"
#    Project     = "${var.tag_project_name}"
#    Environment = "${terraform.workspace}"
#  }
#}
