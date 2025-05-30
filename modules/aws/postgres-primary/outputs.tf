output "postgres_arn" {
  description = "Rds ARN"
  value       = aws_db_instance.rds_postgres.arn
}

output "db_host" {
  description = "RDS Host"
  value       = aws_db_instance.rds_postgres.address
}

output "db_port" {
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