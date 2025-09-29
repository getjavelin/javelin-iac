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

resource "azurerm_network_security_rule" "inbound_rule_6380" {
  name                                          = "allow-inbound-redis-ssl"
  priority                                      = 106
  direction                                     = "Inbound"
  access                                        = "Allow"
  protocol                                      = "Tcp"
  source_port_range                             = "*"
  destination_port_range                        = "6380"
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
  sku_name                                      = var.redis_sku
  family                                        = "C"
  capacity                                      = var.redis_capacity
  minimum_tls_version                           = "1.2"
  non_ssl_port_enabled                          = true
  public_network_access_enabled                 = false
  access_keys_authentication_enabled            = true
  redis_version                                 = 6

  redis_configuration {
    authentication_enabled                      = true
    active_directory_authentication_enabled     = false
    maxmemory_policy                            = "volatile-lru"
    rdb_backup_enabled                          = false
    aof_backup_enabled                          = false
  }

  patch_schedule {
    day_of_week                                 = "Monday"
    start_hour_utc                              = 1
    maintenance_window                          = "PT5H"
  }
  tags                                          = var.tags
}

########## Private_Endpoint ##########
resource "azurerm_private_dns_zone" "redis" {
  name                                          = "privatelink.redis.cache.windows.net"
  resource_group_name                           = var.resource_group_name
  tags                                          = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis" {
  name                                          = "${local.redis_prefix}-redis-vnet-link"
  resource_group_name                           = var.resource_group_name
  private_dns_zone_name                         = azurerm_private_dns_zone.redis.name
  virtual_network_id                            = var.vnet_id
  tags                                          = var.tags
}

resource "azurerm_private_endpoint" "redis" {
  name                                          = "${local.redis_prefix}-redis-pe"
  location                                      = var.location
  resource_group_name                           = var.resource_group_name
  subnet_id                                     = var.private_subnet_id

  private_service_connection {
    name                                        = "${local.redis_prefix}-redis-pe"
    private_connection_resource_id              = azurerm_redis_cache.redis.id
    subresource_names                           = [ "redisCache" ]
    is_manual_connection                        = false
  }

  private_dns_zone_group {
    name                                        = "${local.redis_prefix}-redis-pe-grp"
    private_dns_zone_ids                        = [ azurerm_private_dns_zone.redis.id ]
  }
}