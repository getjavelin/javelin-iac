variable "project_env" {
  description = "Environment of deployment"
  type        = string
}

variable "project_name" {
  description = "Environment of deployment"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "nat_ip_count" {
  description = "NAT IP Count"
  type        = number
}

variable "vnet_cidr" {
  description = "VPC cidr"
  type        = string
}

variable "private_subnet_cidr" {
  description = "private subnet inside the VPC"
  type        = string
}

# variable "private_delegate_subnet_cidr" {
#   description = "private delegate subnet inside the VPC"
#   type        = string
# }

variable "public_subnet_cidr" {
  description = "public subnet inside the VPC"
  type        = string
}

variable "appgw_subnet_cidr" {
  description = "application gw subnet inside the VPC"
  type        = string
}

variable "vnet_all_egress_enable" {
  description = "vnet all egress enable"
  type        = bool
}

variable "tags" {
  description = "tags"
  type        = map(string)
}