output "redis_server_id" {
  description = "redis server id"
  value       = azurerm_redis_cache.redis.id
}

output "redis_host" {
  description = "redis host"
  value       = azurerm_redis_cache.redis.hostname
}

output "redis_port" {
  description = "redis port"
  value       = azurerm_redis_cache.redis.port
}