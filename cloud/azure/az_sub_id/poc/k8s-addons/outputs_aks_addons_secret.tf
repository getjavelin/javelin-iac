output "aks_addons_secret_id" {
  description = "AKS Addon Secret ID"
  value       = var.enable_aks_addons_secret ? module.aks_addons_secret[0].aks_addons_secret_id : null
}

output "aks_addons_secret_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_aks_addons_secret ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> aks_addons_secret" : null
}