output "ssl_keyvault_name" {
  description = "SSL keyvault name"
  value       = azurerm_key_vault.ssl.name
}

output "ssl_keyvault_id" {
  description = "SSL keyvault id"
  value       = azurerm_key_vault.ssl.id 
}

output "ssl_keyvault_ssl_secret_id" {
  description = "SSL keyvault ssl secret id"
  value       = var.enable_self_signed_cert ? azurerm_key_vault_certificate.ssl[0].secret_id : null
}