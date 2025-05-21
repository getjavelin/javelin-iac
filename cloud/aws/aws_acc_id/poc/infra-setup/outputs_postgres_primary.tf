# ################################################## RDS
output "postgres_primary_arn" {
  description = "Rds ARN"
  value       = var.enable_postgres_primary ? module.postgres_primary[0].postgres_arn : null
}

output "postgres_primary_host" {
  description = "RDS Host"
  value       = var.enable_postgres_primary ? module.postgres_primary[0].postgres_host : null
}

output "postgres_primary_port" {
  description = "RDS Port"
  value       = var.enable_postgres_primary ? module.postgres_primary[0].postgres_port : null
}

output "postgres_primary_db_name" {
  description = "Database Name"
  value       = var.enable_postgres_primary ? module.postgres_primary[0].db_name : null
}

output "postgres_primary_db_user" {
  description = "Database Username"
  value       = var.enable_postgres_primary ? module.postgres_primary[0].db_user : null
}

output "postgres_primary_db_pass" {
  description = "Database Username"
  value       = var.enable_postgres_primary ? module.postgres_primary[0].db_pass : null
  sensitive   = true
}

output "postgres_primary_db_javelin_customers_pass" {
  description = "Database User javelin_customers Password"
  value       = var.enable_postgres_primary ? module.postgres_primary[0].db_javelin_customers_pass : null
  sensitive   = true
}

output "postgres_primary_db_javelin_admins_pass" {
  description = "Database User javelin_admins Password"
  value       = var.enable_postgres_primary ? module.postgres_primary[0].db_javelin_admins_pass : null
  sensitive   = true
}

output "postgres_primary_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_postgres_primary ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> postgres_primary" : null
}