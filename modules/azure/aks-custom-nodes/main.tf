########## AKS_Node_Pool ##########
resource "azurerm_kubernetes_cluster_node_pool" "aks_nodepool" {
  for_each                                      = { for nodes in var.aks_nodes_properties : nodes.name => nodes }

  name                                          = each.value.name
  kubernetes_cluster_id                         = var.aks_cluster_id
  vm_size                                       = each.value.aks_node_vm_size
  node_count                                    = each.value.aks_node_min_count
  min_count                                     = each.value.aks_node_min_count
  max_count                                     = each.value.aks_node_max_count
  auto_scaling_enabled                          = true
  host_encryption_enabled                       = true
  temporary_name_for_rotation                   = "${each.value.name}temp"
  node_public_ip_enabled                        = false
  priority                                      = each.value.aks_node_priority
  os_disk_size_gb                               = var.aks_node_disk_size
  mode                                          = "User"
  os_disk_type                                  = "Managed"
  os_sku                                        = "AzureLinux"
  os_type                                       = "Linux"
  vnet_subnet_id                                = var.private_subnet_id
  node_taints                                   = []
  node_labels                                   = {
                                                    "kube/nodegroup"        = "${each.value.name}"
                                                    "kube/nodetype"         = "${each.value.name}-${each.value.aks_node_priority}"
                                                    "kube/project_env"      = "${var.project_env}"
                                                    "kube/project_name"     = "${var.project_name}"
                                                  }
  # eviction_policy                               = "Delete"
  # upgrade_settings {
  #   drain_timeout_in_minutes                    = 10
  #   node_soak_duration_in_minutes               = 0
  #   max_surge                                   = 2
  # }

  lifecycle {
    ignore_changes                              = [ node_count, upgrade_settings, eviction_policy, node_labels, node_taints ]
  }

  tags                                          = var.tags
}