########## Locals ##########
locals {
  vnet_prefix                          = join("-", [ var.project_name, var.project_env ])
}

########## Vnet ##########
resource "azurerm_virtual_network" "vnet" {
  name                                 = "${local.vnet_prefix}-vnet"
  resource_group_name                  = var.resource_group_name
  address_space                        = [ var.vnet_cidr ]
  location                             = var.location
  tags                                 = var.tags

  encryption {
    enforcement                        = "AllowUnencrypted"
  }
}

resource "azurerm_subnet" "private_subnet" {
  name                                 = "${local.vnet_prefix}-private"
  resource_group_name                  = var.resource_group_name
  virtual_network_name                 = azurerm_virtual_network.vnet.name
  address_prefixes                     = [ var.private_subnet_cidr ]
}

# resource "azurerm_subnet" "private_delegate_subnet" {
#   name                                 = "${local.vnet_prefix}-private-delegate"
#   resource_group_name                  = var.resource_group_name
#   virtual_network_name                 = azurerm_virtual_network.vnet.name
#   address_prefixes                     = [ var.private_delegate_subnet_cidr ]
#   service_endpoints                    = [ "Microsoft.Storage" ]

#   delegation {
#     name                              = "postgres"
#     service_delegation {
#       name                            = "Microsoft.DBforPostgreSQL/flexibleServers"
#       actions                         = [
#                                           "Microsoft.Network/virtualNetworks/subnets/join/action"
#                                         ]
#     }
#   }
# }

resource "azurerm_subnet" "public_subnet" {
  name                                 = "${local.vnet_prefix}-public"
  resource_group_name                  = var.resource_group_name
  virtual_network_name                 = azurerm_virtual_network.vnet.name
  address_prefixes                     = [ var.public_subnet_cidr ]
}

resource "azurerm_subnet" "appgw_subnet" {
  name                                 = "${local.vnet_prefix}-appgw"
  resource_group_name                  = var.resource_group_name
  virtual_network_name                 = azurerm_virtual_network.vnet.name
  address_prefixes                     = [ var.appgw_subnet_cidr ]
}

resource "azurerm_public_ip" "nat" {
  count                               = var.nat_ip_count
  name                                = "${local.vnet_prefix}-nat-ip-${count.index + 1}"
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  allocation_method                   = "Static"
  sku                                 = "Standard"
  tags                                = var.tags
}

resource "azurerm_nat_gateway" "nat" {
  name                                = "${local.vnet_prefix}-nat"
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  sku_name                            = "Standard"
  tags                                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat" {
  count                               = var.nat_ip_count

  nat_gateway_id                      = azurerm_nat_gateway.nat.id
  public_ip_address_id                = azurerm_public_ip.nat[count.index].id
}

resource "azurerm_subnet_nat_gateway_association" "nat_private_assoc" {
  subnet_id                           = azurerm_subnet.private_subnet.id
  nat_gateway_id                      = azurerm_nat_gateway.nat.id
}

# resource "azurerm_subnet_nat_gateway_association" "nat_private_delegate_assoc" {
#   subnet_id                           = azurerm_subnet.private_delegate_subnet.id
#   nat_gateway_id                      = azurerm_nat_gateway.nat.id
# }

########## Firewall ##########
locals {
  allowed_subnet_ids                  = [
                                          azurerm_subnet.private_subnet.id,
                                          azurerm_subnet.public_subnet.id
                                        ]
}

resource "azurerm_network_security_group" "vnet" {
  name                                = "${local.vnet_prefix}-vnet-nsg"
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  tags                                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "vnet_access" {
  count                               = length(local.allowed_subnet_ids)

  subnet_id                           = local.allowed_subnet_ids[count.index]
  network_security_group_id           = azurerm_network_security_group.vnet.id
}

resource "azurerm_network_security_rule" "outbound_rule_443" {
  name                                = "allow-outbound-443"
  priority                            = 100
  direction                           = "Outbound"
  access                              = "Allow"
  protocol                            = "Tcp"
  source_port_range                   = "*"
  destination_port_range              = "443"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = var.resource_group_name
  network_security_group_name         = azurerm_network_security_group.vnet.name
}

resource "azurerm_network_security_rule" "outbound_rule_internal" {
  name                                = "allow-outbound-internal"
  priority                            = 101
  direction                           = "Outbound"
  access                              = "Allow"
  protocol                            = "Tcp"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "*"
  destination_address_prefix          = "${var.vnet_cidr}"
  resource_group_name                 = var.resource_group_name
  network_security_group_name         = azurerm_network_security_group.vnet.name
}

resource "azurerm_network_security_rule" "outbound_rule_all" {
  count                               = var.vnet_all_egress_enable == false ? 1 : 0

  name                                = "deny-outbound-all"
  priority                            = 200
  direction                           = "Outbound"
  access                              = "Deny"
  protocol                            = "Tcp"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = var.resource_group_name
  network_security_group_name         = azurerm_network_security_group.vnet.name
}

# resource "azurerm_network_security_rule" "inbound_rule_all" {
#   name                                = "deny-inbound-all"
#   priority                            = 200
#   direction                           = "Inbound"
#   access                              = "Deny"
#   protocol                            = "*"
#   source_port_range                   = "*"
#   destination_port_range              = "*"
#   source_address_prefix               = "VirtualNetwork"
#   destination_address_prefix          = "VirtualNetwork"
#   resource_group_name                 = var.resource_group_name
#   network_security_group_name         = azurerm_network_security_group.vnet.name
# }