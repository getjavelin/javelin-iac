output "postgres_server_id" {
  description = "postgres server id"
  value       = azurerm_postgresql_flexible_server.postgres.id
}

output "postgres_host" {
  description = "postgres host"
  value       = "${azurerm_postgresql_flexible_server.postgres.name}.privatelink.postgres.database.azure.com"
}

output "postgres_private_ip" {
  description = "postgres private_ip"
  value       = azurerm_private_endpoint.postgres.private_service_connection[0].private_ip_address
}

output "postgres_port" {
  description = "postgres port"
  value       = var.db_port
}