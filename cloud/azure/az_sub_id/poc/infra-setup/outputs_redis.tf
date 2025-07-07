output "redis_server_id" {
  description = "redis server id"
  value       = var.enable_redis ? module.redis[0].redis_server_id : null
}

output "redis_host" {
  description = "redis host"
  value       = var.enable_redis ? module.redis[0].redis_host : null
}

output "redis_port" {
  description = "redis port"
  value       = var.enable_redis ? module.redis[0].redis_port : null
}

output "redis_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_redis ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> redis" : null
}