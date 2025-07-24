output "traffic_manager_profile_id" {
  description = "Traffic Manager profile ID"
  value       = azurerm_traffic_manager_profile.tm.id
}

output "traffic_manager_domain" {
  description = "Traffic Manager domain"
  value       = azurerm_traffic_manager_profile.tm.fqdn
}

output "traffic_manager_external_endpoint_id" {
  description = "Traffic Manager external endpoint ID"
  value       = azurerm_traffic_manager_external_endpoint.tm.id
}