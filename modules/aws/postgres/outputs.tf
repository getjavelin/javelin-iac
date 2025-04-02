output "postgres_arn" {
  description = "Rds ARN"
  value       = aws_db_instance.rds_postgres.arn
}

output "postgres_host" {
  description = "RDS Host"
  value       = aws_db_instance.rds_postgres.address
}

output "postgres_port" {
  description = "RDS Port"
  value       = aws_db_instance.rds_postgres.port
}

output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.rds_postgres.db_name
}

output "db_user" {
  description = "Database Username"
  value       = aws_db_instance.rds_postgres.username
}

output "db_pass" {
  description = "Database Password"
  value       = aws_db_instance.rds_postgres.password
  sensitive   = true
}

output "db_javelin_customers_pass" {
  description = "Database User javelin_customers Password"
  value       = random_password.javelin_customers_password.result
  sensitive   = true
}

output "db_javelin_admins_pass" {
  description = "Database User javelin_admins Password"
  value       = random_password.javelin_admins_password.result
  sensitive   = true
}

output "secret_name" {
  description = "Database Password Secret Name"
  value       = aws_secretsmanager_secret.rds_password.name
}

output "secret_arn" {
  description = "Database Password Secret ARN"
  value       = aws_secretsmanager_secret.rds_password.arn
}