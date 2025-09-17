########## Locals ##########
locals {
  agw_prefix                                      = join("-", [ var.project_name, var.project_env ])
  be_pool_cfg_name                                = "${local.agw_prefix}-aks-appgw-bepool"
  fe_ip_cfg_name                                  = "${local.agw_prefix}-aks-appgw-feip"
  http_port_cfg_name                              = "${local.agw_prefix}-aks-appgw-http-port"
  https_port_cfg_name                             = "${local.agw_prefix}-aks-appgw-https-port"
  http_listener_cfg_name                          = "${local.agw_prefix}-aks-appgw-http-listener"
}

########## AGW_IP ##########
resource "azurerm_public_ip" "appgw" {
  name                                            = "${local.agw_prefix}-aks-appgw-ip"
  location                                        = var.location
  resource_group_name                             = var.resource_group_name
  allocation_method                               = "Static"
  sku                                             = "Standard"
  zones                                           = var.appgw_zones
  tags                                            = var.tags
}

########## Identity ##########
resource "azurerm_user_assigned_identity" "appgw" {
  name                                            = "${local.agw_prefix}-appgw-identity"
  resource_group_name                             = var.resource_group_name
  location                                        = var.location
  tags                                            = var.tags
}

########## Application_Gateway ##########
resource "azurerm_application_gateway" "appgw" {
  name                                            = "${local.agw_prefix}-aks-appgw"
  location                                        = var.location
  resource_group_name                             = var.resource_group_name
  zones                                           = var.appgw_zones

  sku {
    name                                          = "Standard_v2"
    tier                                          = "Standard_v2"
  }

  identity {
    type                                          = "UserAssigned"
    identity_ids                                  = [ azurerm_user_assigned_identity.appgw.id ]
  }

  autoscale_configuration {
    min_capacity                                  = 2
    max_capacity                                  = 5
  }

  gateway_ip_configuration {
    name                                          = "${local.agw_prefix}-aks-appgw-config"
    subnet_id                                     = var.appgw_subnet_id
  }

  dynamic "ssl_certificate" {
    for_each                                      = var.ssl_keyvault_secret_ids
    content {
      name                                        = ssl_certificate.value.name
      key_vault_secret_id                         = ssl_certificate.value.keyvault_secret_id
    }
  }

  backend_address_pool {
    name                                          = local.be_pool_cfg_name
  }

  backend_http_settings {
    name                                          = local.http_port_cfg_name
    cookie_based_affinity                         = "Disabled"
    port                                          = 80
    protocol                                      = "Http"
    request_timeout                               = 20
  }

  frontend_ip_configuration {
    name                                          = local.fe_ip_cfg_name
    public_ip_address_id                          = azurerm_public_ip.appgw.id
  }

  frontend_port {
    name                                          = local.http_port_cfg_name
    port                                          = 80
  }

  http_listener {
    name                                          = local.http_listener_cfg_name
    frontend_ip_configuration_name                = local.fe_ip_cfg_name
    frontend_port_name                            = local.http_port_cfg_name
    protocol                                      = "Http"
  }

  request_routing_rule {
    name                                          = "${local.agw_prefix}-aks-appgw-routing-rule"
    priority                                      = 100
    rule_type                                     = "Basic"
    http_listener_name                            = local.http_listener_cfg_name
    backend_address_pool_name                     = local.be_pool_cfg_name
    backend_http_settings_name                    = local.http_port_cfg_name
  }

  tags                                            = var.tags

  lifecycle {
    ignore_changes                                = [ 
                                                      backend_address_pool,
                                                      backend_http_settings,
                                                      frontend_port,
                                                      http_listener,
                                                      probe,
                                                      request_routing_rule,
                                                      redirect_configuration,
                                                      tags
                                                    ]
  }
}

########## Identity_Permission ##########
resource "azurerm_role_assignment" "appgw" {
  count                                         = length(var.appgw_keyvault_role_list)

  scope                                         = var.ssl_keyvault_id
  role_definition_name                          = var.appgw_keyvault_role_list[count.index]
  principal_id                                  = azurerm_user_assigned_identity.appgw.principal_id
}