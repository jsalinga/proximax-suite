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
# ProxiSuite-Experimental
#---------------------
variable "suite_app_public_key" {
  description = "ProxiSuite-Experimental Server Public Key"
}

variable "suite_app_ec2_type" {
  description = "ProxiSuite-Experimental EC2 Instance Type"
}
