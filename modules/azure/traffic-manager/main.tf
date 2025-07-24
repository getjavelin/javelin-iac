########## Locals ##########
locals {
  tm_prefix                                       = join("-", [ var.project_name, var.project_env ])
}

########## DNS_Name ##########
resource "random_id" "tm" {
  keepers                                         = {
                                                      tm_id = local.tm_prefix
                                                    }
  byte_length                                     = 8
}

########## Traffic_Manager ##########
resource "azurerm_traffic_manager_profile" "tm" {
  name                                            = "${local.tm_prefix}-global"
  resource_group_name                             = var.resource_group_name
  profile_status                                  = "Enabled"
  traffic_routing_method                          = "Weighted"

  dns_config {
    relative_name                                 = random_id.tm.hex
    ttl                                           = 30
  }

  monitor_config {
    protocol                                      = "HTTPS"
    port                                          = 443
    path                                          = "/"
    interval_in_seconds                           = 30
    timeout_in_seconds                            = 5
    tolerated_number_of_failures                  = 3
  }

  tags                                            = var.tags
}

resource "azurerm_traffic_manager_external_endpoint" "tm" {
  # name                                            = "${local.tm_prefix}-endpoint"
  name                                            = "global-endpoint"
  enabled                                         = true
  always_serve_enabled                            = true
  profile_id                                      = azurerm_traffic_manager_profile.tm.id
  weight                                          = 1
  target                                          = var.appgw_ip

  lifecycle {
    ignore_changes                                = [ target ]
  }
}