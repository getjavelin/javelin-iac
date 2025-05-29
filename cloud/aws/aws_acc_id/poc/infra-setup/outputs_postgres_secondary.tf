output "postgres_secondary_arn" {
  description = "Rds ARN"
  value       = var.enable_postgres_secondary ? module.postgres_secondary[0].postgres_arn : null
}

output "postgres_secondary_host" {
  description = "RDS Host"
  value       = var.enable_postgres_secondary ? module.postgres_secondary[0].db_host : null
}

output "postgres_secondary_port" {
  description = "RDS Port"
  value       = var.enable_postgres_secondary ? module.postgres_secondary[0].db_port : null
}

output "postgres_secondary_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_postgres_secondary ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> postgres_secondary" : null
}