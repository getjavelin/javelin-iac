output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  description = "AKS cluster id"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_log_workspace" {
  description = "AKS log workspace"
  value       = azurerm_log_analytics_workspace.log.id
}

output "aks_cluster_kubeconfig" {
  description = "AKS cluster kube config"
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config[0]
  sensitive   = true
}

output "aks_oidc_issuer_url" {
  description = "AKS oidc issuer url"
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}