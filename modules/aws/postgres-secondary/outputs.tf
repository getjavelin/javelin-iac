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