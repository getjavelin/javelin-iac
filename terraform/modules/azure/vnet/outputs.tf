output "vnet_name" {
  description = "Vnet name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Vnet id"
  value       = azurerm_virtual_network.vnet.id
}

output "private_subnet_name" {
  description = "Private subnet name"
  value       = azurerm_subnet.private_subnet.name
}

output "private_subnet_id" {
  description = "Private subnet id"
  value       = azurerm_subnet.private_subnet.id
}

output "private_subnet_cidr" {
  description = "Private subnet cidr"
  value       = var.private_subnet_cidr
}

# output "private_delegate_subnet_name" {
#   description = "Private delegate subnet name"
#   value       = azurerm_subnet.private_delegate_subnet.name
# }

# output "private_delegate_subnet_id" {
#   description = "Private delegate subnet id"
#   value       = azurerm_subnet.private_delegate_subnet.id
# }

# output "private_delegate_subnet_cidr" {
#   description = "Private delegate subnet cidr"
#   value       = var.private_delegate_subnet_cidr
# }

output "appgw_subnet_name" {
  description = "App GW subnet name"
  value       = azurerm_subnet.appgw_subnet.name
}

output "appgw_subnet_id" {
  description = "App GW subnet id"
  value       = azurerm_subnet.appgw_subnet.id
}

output "appgw_subnet_cidr" {
  description = "App GW subnet cidr"
  value       = var.appgw_subnet_cidr
}

output "public_subnet_name" {
  description = "Public subnet name"
  value       = azurerm_subnet.public_subnet.name
}

output "public_subnet_id" {
  description = "Public subnet id"
  value       = azurerm_subnet.public_subnet.id
}

output "public_subnet_cidr" {
  description = "Public subnet cidr"
  value       = var.public_subnet_cidr
}

output "nat_gateway_name" {
  description = "NAT name"
  value       = azurerm_nat_gateway.nat.name
}

output "nat_gateway_id" {
  description = "NAT id"
  value       = azurerm_nat_gateway.nat.id
}

output "nat_gateway_ip" {
  description = "NAT ip"
  value       = [ for ip in azurerm_public_ip.nat : ip.ip_address ]
}

output "vnet_nsg_name" {
  description = "vnet nsg name"
  value       = azurerm_network_security_group.vnet.name
}

output "vnet_nsg_id" {
  description = "vnet nsg id"
  value       = azurerm_network_security_group.vnet.id
}