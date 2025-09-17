output "postgres_kms_key" {
  description = "RDS KMS Key"
  value       = aws_kms_key.rds_kms.arn
}

output "postgres_pramas_grp" {
  description = "RDS Parameter Group"
  value       = aws_db_parameter_group.rds_postgres.name
}

output "postgres_subnet_grp" {
  description = "RDS Subnet Group"
  value       = aws_db_subnet_group.rds_subnet_group.name
}

output "postgres_security_grp" {
  description = "RDS Security Group"
  value       = aws_security_group.rds_sg.id
}

output "postgres_secret_name" {
  description = "Database Password Secret Name"
  value       = aws_secretsmanager_secret.rds_password.name
}

output "postgres_secret_arn" {
  description = "Database Password Secret ARN"
  value       = aws_secretsmanager_secret.rds_password.arn
}