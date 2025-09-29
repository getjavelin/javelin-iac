output "redis_cluster_host" {
  description = "Redis Cluster Host"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "redis_cluster_port" {
  description = "Redis Cluster Port"
  value       = aws_elasticache_replication_group.redis.port
}

output "redis_cluster_pass" {
  description = "Redis Cluster Password"
  value       = aws_elasticache_replication_group.redis.auth_token
  sensitive   = true
}