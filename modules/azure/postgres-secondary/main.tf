########## Locals ##########
locals {
  postgres_prefix                               = join("-", [ var.project_name, var.project_env ])
}

########## Postgres ##########
resource "azurerm_postgresql_flexible_server" "postgres" {
  name                                          = "${local.postgres_prefix}-postgres"
  location                                      = var.location
  resource_group_name                           = var.resource_group_name
  sku_name                                      = var.postgres_sku_name
  create_mode                                   = "Replica"
  source_server_id                              = var.postgres_source_server_id
  storage_mb                                    = var.postgres_storage_mb
  storage_tier                                  = var.postgres_storage_tier
  auto_grow_enabled                             = true
  # delegated_subnet_id                           = var.delegated_subnet_id
  # private_dns_zone_id                           = var.private_dns_zone_id
  backup_retention_days                         = var.backup_retention_days
  geo_redundant_backup_enabled                  = false

  customer_managed_key {
    key_vault_key_id                            = var.des_keyvault_key_id
    primary_user_assigned_identity_id           = var.identity_id
  }

  identity {
    type                                        = "UserAssigned"
    identity_ids                                = [ var.identity_id ]
  }

  # high_availability {
  #   mode                                        = "ZoneRedundant"
  # }

  maintenance_window {
    day_of_week                                 = 1
    start_hour                                  = 1
    start_minute                                = 0
  }

  lifecycle {
    ignore_changes                              = [ zone ]
  }

  tags                                          = var.tags
}

resource "azurerm_management_lock" "postgres" {
  count                                         = var.enable_delete_lock == true ? 1 : 0

  name                                          = "${local.postgres_prefix}-postgres-lock"
  scope                                         = azurerm_postgresql_flexible_server.postgres.id
  lock_level                                    = "CanNotDelete"  # or "ReadOnly"
  notes                                         = "ManagedBy Terraform"

  lifecycle {
    prevent_destroy                             = true
  }
}

########## Private_Endpoint ##########
resource "azurerm_private_endpoint" "postgres" {
  name                                          = "${local.postgres_prefix}-postgres-pe"
  location                                      = var.location
  resource_group_name                           = var.resource_group_name
  subnet_id                                     = var.private_subnet_id

  private_service_connection {
    name                                        = "${local.postgres_prefix}-postgres-pe"
    private_connection_resource_id              = azurerm_postgresql_flexible_server.postgres.id
    subresource_names                           = [ "postgresqlServer" ]
    is_manual_connection                        = false
  }

  private_dns_zone_group {
    name                                        = "${local.postgres_prefix}-postgres-pe-grp"
    private_dns_zone_ids                        = [ var.private_dns_zone_id ]
  }
}

########## Server_Param ##########
resource "azurerm_postgresql_flexible_server_configuration" "postgres_params" {
  for_each                                      = { for params in var.postgres_server_params : params.name => params }

  name                                          = each.value.name
  server_id                                     = azurerm_postgresql_flexible_server.postgres.id
  value                                         = each.value.value
}

########## KeyVault_Secrets ##########
locals {
  secret_string = {
    "engine"      = "postgres"
    "dbname"      = ""
    "username"    = ""
    "password"    = ""
    "privateip"   = ""
    "host"        = "${azurerm_postgresql_flexible_server.postgres.name}.private.postgres.database.azure.com"
    "port"        = "${var.db_port}"
    "id"          = "${azurerm_postgresql_flexible_server.postgres.id}"
  }
}

resource "azurerm_key_vault_secret" "postgres" {
  for_each                                      = local.secret_string
  name                                          = each.key
  value                                         = each.value
  key_vault_id                                  = var.secret_keyvault_id
  tags                                          = var.tags

  lifecycle {
    ignore_changes                              = [ value ]
  }
}