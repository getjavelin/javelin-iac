data "azurerm_resource_group" "rg" {
  name                                          = var.resource_group_name
}

resource "azurerm_role_assignment" "self" {
  count                                         = length(var.self_keyvault_role_list)

  scope                                         = data.azurerm_resource_group.rg.id
  role_definition_name                          = var.self_keyvault_role_list[count.index]
  principal_id                                  = var.ad_object_id

  lifecycle {
    ignore_changes                              = [ principal_id ]
  }
}