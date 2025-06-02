output "aurora_cluster_arn" {
  description = "Aurora cluster ARN"
  value       = aws_rds_cluster.aurora_global.arn
}

output "db_host" {
  description = "Aurora Host"
  value       = aws_rds_cluster.aurora_global.endpoint
}

output "db_port" {
  description = "Aurora Port"
  value       = aws_rds_cluster.aurora_global.port
}