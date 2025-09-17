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

output "postgres_db_name" {
  description = "postgres database Name"
  value       = var.db_name
}

output "postgres_db_user" {
  description = "postgres database Username"
  value       = azurerm_postgresql_flexible_server.postgres.administrator_login
}

output "postgres_db_pass" {
  description = "postgres database Password"
  value       = azurerm_postgresql_flexible_server.postgres.administrator_password
  sensitive   = true
}