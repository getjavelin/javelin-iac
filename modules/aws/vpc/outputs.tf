output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.vpc.azs
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "database_subnet_ids" {
  description = "The IDs of the database subnets"
  value       = module.vpc.database_subnets
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

output "public_route_table_ids" {
  description = "The IDs of the public route table"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "The IDs of the private route table"
  value       = module.vpc.private_route_table_ids
}

output "database_route_table_ids" {
  description = "The IDs of the database route table"
  value       = module.vpc.database_route_table_ids
}