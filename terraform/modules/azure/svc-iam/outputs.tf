output "app_uami_client_id" {
  description = "App uami client id"
  value       = azurerm_user_assigned_identity.app.client_id
}