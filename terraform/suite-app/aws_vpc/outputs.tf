#------------------------------------------------------------
# Output from Terraform registry
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/1.30.0?tab=outputs
#------------------------------------------------------------
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnets}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnets}"
}

output "bastion_host_security_group_id" {
  value = "${aws_security_group.bastion_host_sg.id}"
}

output "public_subnets_cidr_blocks" {
  value = "${module.vpc.public_subnets_cidr_blocks}"
}

output "private_subnets_cidr_blocks" {
  value = "${module.vpc.private_subnets_cidr_blocks}"
}