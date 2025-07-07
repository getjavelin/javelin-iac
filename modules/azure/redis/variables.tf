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

variable "vnet_cidr" {
  description = "vnet cidr"
  type        = string
}

variable "private_subnet_id" {
  description = "private subnet id"
  type        = string
}

variable "redis_capacity" {
  description = "redis capacity"
  type        = number
}

variable "vnet_nsg_name" {
  description = "vnet nsg name"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map(string)
}