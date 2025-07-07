output "aks_nodepool_id" {
  description = "AKS custom nodepool id"
  value       = [ for nodes in azurerm_kubernetes_cluster_node_pool.aks_nodepool : nodes.id ]
}