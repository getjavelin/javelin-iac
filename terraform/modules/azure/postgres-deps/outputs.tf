output "postgres_identity_name" {
  description = "postgres identity name"
  value       = azurerm_user_assigned_identity.postgres.name
}

output "postgres_identity_id" {
  description = "postgres identity id"
  value       = azurerm_user_assigned_identity.postgres.id
}

output "postgres_private_dns_zone_name" {
  description = "postgres private dns zone name"
  value       = azurerm_private_dns_zone.postgres.name
}

output "postgres_private_dns_zone_id" {
  description = "postgres private dns zone id"
  value       = azurerm_private_dns_zone.postgres.id
}

output "postgres_keyvault_name" {
  description = "postgres keyvault name"
  value       = azurerm_key_vault.postgres.name
}

output "postgres_keyvault_id" {
  description = "postgres keyvault id"
  value       = azurerm_key_vault.postgres.id
}