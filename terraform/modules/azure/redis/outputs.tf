output "redis_server_id" {
  description = "redis server id"
  value       = azurerm_redis_cache.redis.id
}

output "redis_host" {
  description = "redis host"
  value       = "${azurerm_redis_cache.redis.name}.privatelink.redis.cache.windows.net"
}

output "redis_private_ip" {
  description = "redis private_ip"
  value       = azurerm_private_endpoint.redis.private_service_connection[0].private_ip_address
}

output "redis_port" {
  description = "redis port"
  value       = azurerm_redis_cache.redis.port
}

output "redis_primary_access_key" {
  description = "redis port"
  sensitive   = true
  value       = azurerm_redis_cache.redis.primary_access_key
}