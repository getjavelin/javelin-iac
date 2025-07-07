########## Locals ##########
locals {
  aks_prefix                                  = join("-", [ var.project_name, var.project_env ])
}

########## Log ##########
resource "azurerm_log_analytics_workspace" "log" {
  name                                        = "${local.aks_prefix}-aks-logs"
  location                                    = var.location
  resource_group_name                         = var.resource_group_name
  sku                                         = "PerGB2018"
  retention_in_days                           = var.aks_log_retention_in_days
}

########## AKS ##########
resource "azurerm_kubernetes_cluster" "aks" {
  name                                        = "${local.aks_prefix}-aks"
  location                                    = var.location
  resource_group_name                         = var.resource_group_name
  dns_prefix                                  = local.aks_prefix
  # automatic_upgrade_channel                   = "stable"
  private_cluster_enabled                     = false
  disk_encryption_set_id                      = var.des_id
  image_cleaner_enabled                       = true
  image_cleaner_interval_hours                = 24
  kubernetes_version                          = var.aks_version
  node_resource_group                         = "${local.aks_prefix}-aks"
  workload_identity_enabled                   = true
  oidc_issuer_enabled                         = true
  role_based_access_control_enabled           = true
  sku_tier                                    = "Free"

  storage_profile {
    blob_driver_enabled                       = true
    disk_driver_enabled                       = true
    file_driver_enabled                       = true
    snapshot_controller_enabled               = true
  }

  monitor_metrics {
    annotations_allowed                       = null
    labels_allowed                            = null
  }

  oms_agent {
    log_analytics_workspace_id                = azurerm_log_analytics_workspace.log.id
    msi_auth_for_monitoring_enabled           = true
  }

  ingress_application_gateway {
    gateway_id                                = var.application_gw_id
  }

  api_server_access_profile {
    authorized_ip_ranges                      = var.aks_authorized_networks
  }

  azure_active_directory_role_based_access_control {
    tenant_id                                 = var.tenant_id
    admin_group_object_ids                    = var.aks_auth_object_ids
    azure_rbac_enabled                        = true
  }

  auto_scaler_profile {
    balance_similar_node_groups               = false
    expander                                  = "random"
    max_graceful_termination_sec              = 600
    max_node_provisioning_time                = "20m"
  }

  workload_autoscaler_profile {
    keda_enabled                              = true
    vertical_pod_autoscaler_enabled           = true
  }

  default_node_pool {
    name                                      = "default"
    auto_scaling_enabled                      = true
    scale_down_mode                           = "Delete"
    node_count                                = 1
    min_count                                 = 1
    max_count                                 = 2
    vm_size                                   = var.aks_default_node_vm_size
    host_encryption_enabled                   = true
    node_public_ip_enabled                    = false
    os_disk_type                              = "Managed"
    os_disk_size_gb                           = 64
    os_sku                                    = "AzureLinux"
    type                                      = "VirtualMachineScaleSets"
    vnet_subnet_id                            = var.private_subnet_id
    temporary_name_for_rotation               = "defaulttemp"
    tags                                      = var.tags
    node_labels                               = {
                                                  "kube/nodegroup"        = "default"
                                                  "kube/nodetype"         = "default"
                                                  "kube/project_env"      = "${var.project_env}"
                                                  "kube/project_name"     = "${var.project_name}"
                                                }
    upgrade_settings {
      drain_timeout_in_minutes                = 10
      node_soak_duration_in_minutes           = 0
      max_surge                               = 2
    }
  }

  identity {
    type                                      = "SystemAssigned"
  }

  maintenance_window {
    allowed {
      day                                     = "Monday"
      hours                                   = [ 2 ]
    }
  }

  maintenance_window_node_os {
    frequency                                 = "Weekly"
    interval                                  = 1
    duration                                  = 4
    day_of_week                               = "Monday"
    start_time                                = "01:00"
  }

  network_profile {
    network_plugin                            = "azure"
    network_policy                            = "azure"
    network_data_plane                        = "azure"
    outbound_type                             = "userAssignedNATGateway"
    ip_versions                               = [ "IPv4" ]
    load_balancer_sku                         = "standard"
    service_cidr                              = var.aks_service_cidr
    dns_service_ip                            = var.aks_dns_service_ip
  }

  tags                                        = var.tags

  lifecycle {
    ignore_changes                            = [ 
                                                  default_node_pool[0].node_count,
                                                  maintenance_window_node_os[0].utc_offset
                                                ]
  }
}

########## Identity_Permission ##########
resource "azurerm_role_assignment" "aks_des_reader" {
  scope                                       = var.des_id
  role_definition_name                        = "Reader"
  principal_id                                = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

data "azurerm_resource_group" "resource_group" {
  name                                        = var.resource_group_name
}

data "azuread_service_principal" "agic_identity" {
  depends_on                                  = [ azurerm_kubernetes_cluster.aks ]
  display_name                                = "ingressapplicationgateway-${azurerm_kubernetes_cluster.aks.name}"
}

resource "azurerm_role_assignment" "agic_rg_reader" {
  scope                                       = data.azurerm_resource_group.resource_group.id
  role_definition_name                        = "Reader"
  principal_id                                = data.azuread_service_principal.agic_identity.object_id
}

resource "azurerm_role_assignment" "agic_appgw_contributor" {
  scope                                       = var.application_gw_id
  role_definition_name                        = "Contributor"
  principal_id                                = data.azuread_service_principal.agic_identity.object_id
}

resource "azurerm_role_assignment" "agic_appgw_assign_uami" {
  scope                                       = var.application_gw_identity_id
  role_definition_name                        = "Managed Identity Operator"
  principal_id                                = data.azuread_service_principal.agic_identity.object_id
}

resource "azurerm_role_assignment" "agic_appgw_subnet_join" {
  scope                                       = var.appgw_subnet_id
  role_definition_name                        = "Network Contributor"
  principal_id                                = data.azuread_service_principal.agic_identity.object_id
}