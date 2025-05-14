output "postgres_deps_pramas_grp" {
  description = "RDS Parameter Group"
  value       = var.enable_postgres_deps ? module.postgres_deps[0].postgres_pramas_grp : null
}

output "postgres_deps_subnet_grp" {
  description = "RDS Subnet Group"
  value       = var.enable_postgres_deps ? module.postgres_deps[0].postgres_subnet_grp : null
}

output "postgres_deps_security_grp" {
  description = "RDS Security Group"
  value       = var.enable_postgres_deps ? module.postgres_deps[0].postgres_security_grp : null
}

output "postgres_deps_secret_name" {
  description = "Database Password Secret Name"
  value       = var.enable_postgres_deps ? module.postgres_deps[0].postgres_secret_name : null
}

output "postgres_deps_secret_arn" {
  description = "Database Password Secret ARN"
  value       = var.enable_postgres_deps ? module.postgres_deps[0].postgres_secret_arn : null
}

output "postgres_deps_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_postgres_deps ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> postgres_deps" : null
}