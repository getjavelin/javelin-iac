########## Locals ##########
locals {
  iam_prefix                                    = join("-", ([ var.project_name, var.project_env ]))
}

data "azurerm_resource_group" "rg" {
  name                                          = var.resource_group_name
}

########## UAMI ##########
resource "azurerm_user_assigned_identity" "app" {
  name                                          = "${local.iam_prefix}-app-identity"
  resource_group_name                           = var.resource_group_name
  location                                      = var.location
  tags                                          = var.tags
}

resource "azurerm_role_assignment" "app" {
  count                                         = length(var.app_role_list)

  scope                                         = data.azurerm_resource_group.rg.id
  role_definition_name                          = var.app_role_list[count.index]
  principal_id                                  = azurerm_user_assigned_identity.app.principal_id
}

resource "azurerm_federated_identity_credential" "app" {
  for_each                                      = { for id in var.workload_identity : id.id => id }

  name                                          = "${each.value.namespace}-${each.value.serviceaccount}-fic"
  resource_group_name                           = var.resource_group_name
  parent_id                                     = azurerm_user_assigned_identity.app.id
  audience                                      = [ "api://AzureADTokenExchange" ]
  issuer                                        = var.aks_oidc_issuer_url
  subject                                       = "system:serviceaccount:${each.value.namespace}:${each.value.serviceaccount}"
}