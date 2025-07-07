########## Locals ##########
locals {
  redis_prefix                                  = join("-", [ var.project_name, var.project_env ])
}

########## Firewall ##########
resource "azurerm_network_security_rule" "inbound_rule_6379" {
  name                                          = "allow-inbound-redis"
  priority                                      = 104
  direction                                     = "Inbound"
  access                                        = "Allow"
  protocol                                      = "Tcp"
  source_port_range                             = "*"
  destination_port_range                        = "6379"
  source_address_prefix                         = "${var.vnet_cidr}"
  destination_address_prefix                    = "*"
  resource_group_name                           = var.resource_group_name
  network_security_group_name                   = var.vnet_nsg_name
}

########## Redis ##########
resource "azurerm_redis_cache" "redis" {
  name                                          = "${local.redis_prefix}-redis"
  location                                      = var.location
  resource_group_name                           = var.resource_group_name
  sku_name                                      = "Premium"
  family                                        = "P"
  capacity                                      = var.redis_capacity
  minimum_tls_version                           = "1.2"
  non_ssl_port_enabled                          = true
  public_network_access_enabled                 = false
  redis_version                                 = 6
  subnet_id                                     = var.private_subnet_id

  # redis_configuration {
  #   authentication_enabled                      = false
  #   active_directory_authentication_enabled     = false
  #   rdb_backup_enabled                          = false
  #   aof_backup_enabled                          = false
  #   maxmemory_reserved                          = 200
  #   maxfragmentationmemory_reserved             = 200
  #   maxmemory_delta                             = 200
  #   maxmemory_policy                            = "allkeys-lru"
  # }

  patch_schedule {
    day_of_week                                 = "Monday"
    start_hour_utc                              = 1
    maintenance_window                          = "PT5H"
  }
  tags                                          = var.tags
}