output "aurora_cluster_pramas_grp" {
  description = "Aurora Cluster Parameter Group"
  value       = aws_rds_cluster_parameter_group.aurora_postgres.name
}

output "aurora_db_pramas_grp" {
  description = "Aurora DB Parameter Group"
  value       = aws_db_parameter_group.aurora_postgres.name
}

output "aurora_subnet_grp" {
  description = "Aurora Subnet Group"
  value       = aws_db_subnet_group.aurora_postgres.name
}

output "aurora_kms_key_arn" {
  description = "Aurora KMS Key ARN"
  value       = aws_kms_key.aurora_kms.arn
}

output "aurora_security_grp" {
  description = "Aurora Security Group"
  value       = aws_security_group.aurora_postgres.id
}

output "aurora_secret_name" {
  description = "Aurora Password Secret Name"
  value       = aws_secretsmanager_secret.aurora_password.name
}

output "aurora_secret_arn" {
  description = "Aurora Password Secret ARN"
  value       = aws_secretsmanager_secret.aurora_password.arn
}