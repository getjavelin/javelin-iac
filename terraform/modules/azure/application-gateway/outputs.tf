output "appgw_ip_address" {
  description = "application gateway ip address"
  value       = azurerm_public_ip.appgw.ip_address
}

output "appgw_identity_id" {
  description = "application gateway user identity"
  value       = azurerm_user_assigned_identity.appgw.id
}

output "appgw_name" {
  description = "application gateway name"
  value       = azurerm_application_gateway.appgw.name
}

output "appgw_id" {
  description = "application gateway id"
  value       = azurerm_application_gateway.appgw.id
}