# data "aws_availability_zones" "available" {}

########## Locals ##########
locals {
  vpc_name = join("-", [var.project_name, var.project_env, "vpc"])
}

# data "aws_region" "current" {}

########## VPC ##########
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.0"

  name            = local.vpc_name
  cidr            = var.vpc_cidr
  # azs              = formatlist("${data.aws_region.current.name}%s", ["a", "b", "c"])
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # Enable this only if you need database subnet
  database_subnets                   = var.database_subnets
  create_database_subnet_group       = var.create_database_subnet_group
  create_database_subnet_route_table = var.create_database_subnet_route_table

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames   = true
  enable_dns_support     = true

  # Additional tags
  # Additional tags for the public subnets
  public_subnet_tags = {
    Subnet_Type = "Public Subnets"
  }
  # Additional tags for the private subnets
  private_subnet_tags = {
    Subnet_Type = "Private Subnets"
  }
  # Additional tags for the private subnets
  database_subnet_tags = {
    Subnet_Type = "Database Subnets"
  }

  # Instances launched into the Public subnet should be assigned a public IP address. Specify true to indicate that instances launched into the subnet should be assigned a public IP address
  map_public_ip_on_launch = true
}
