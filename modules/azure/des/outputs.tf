output "des_keyvault_name" {
  description = "DES keyvault name"
  value       = azurerm_key_vault.des.name
}

output "des_keyvault_id" {
  description = "DES keyvault id"
  value       = azurerm_key_vault.des.id
}

output "des_keyvault_key_name" {
  description = "DES keyvault key name"
  value       = azurerm_key_vault_key.des.name
}

output "des_keyvault_key_id" {
  description = "DES keyvault key id"
  value       = azurerm_key_vault_key.des.id
}

output "des_name" {
  description = "DES name"
  value       = azurerm_disk_encryption_set.des.name
}

output "des_id" {
  description = "DES id"
  value       = azurerm_disk_encryption_set.des.id
}