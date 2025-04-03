# ################################################## Redis
output "redis_host" {
  description = "Redis Host"
  value       = var.enable_redis ? module.redis[0].redis_host : null
}

output "redis_port" {
  description = "Redis Port"
  value       = var.enable_redis ? module.redis[0].redis_port : null
}

output "redis_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_redis ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> redis" : null
}