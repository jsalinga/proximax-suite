#---------------------
# AWS PROVIDER
#---------------------
variable "aws_region" {
  description = "AWS Set Region"
}

#---------------------
# General vars
#---------------------
variable "tag_project_name" {
  description = "Project Name"
}


#---------------------
# VPC
#---------------------
variable "vpc_cidr" {
  description = "VPC CIDR Block"
}

variable "vpc_region_az" {
  type        = "list"
  description = "VPC Region Availability Zone"
}

variable "public_subnet_cidr" {
  type        = "list"
  description = "VPC List of CIDR Block for public subnets"
}

variable "private_subnet_cidr" {
  type        = "list"
  description = "VPC List of CIDR Block for private subnets"
}

variable "database_subnet_cidr" {
  type        = "list"
  description = "VPC List of CIDR Block for database private subnets"
}


# Bastion Host
#variable "bastion_host_public_key" {
#  description = "EC2 instance Bastion Host public key"
#}

variable "bastion_host_ssh_cidr_block" {
  type        = "list"
  description = "Bastion host valid CIDR block for SSH access"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default = true
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default = false
}
