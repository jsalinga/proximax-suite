aws_region = "ap-southeast-1"

vpc_cidr = "10.3.0.0/16"

vpc_region_az = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

public_subnet_cidr = ["10.3.1.0/24", "10.3.2.0/24", "10.3.3.0/24"]

private_subnet_cidr = ["10.3.101.0/24", "10.3.102.0/24", "10.3.103.0/24"]

database_subnet_cidr = ["10.3.201.0/24", "10.3.202.0/24", "10.3.203.0/24"]

#bastion_host_public_key = "~/keys/suite_bastion_host_keypair.pub"

enable_dns_hostnames = true

enable_dns_support = true

enable_nat_gateway = true

single_nat_gateway = true
