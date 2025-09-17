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

variable "vnet_id" {
  description = "vnet id"
  type        = string
}

variable "vnet_cidr" {
  description = "vnet cidr"
  type        = string
}

variable "tenant_id" {
  description = "tenant id"
  type        = string
}

variable "vnet_nsg_name" {
  description = "vnet nsg name"
  type        = string
}

variable "postgres_role_list" {
  description = "Postgres Role List"
  type        = list(string)
  default     = [
                  "Key Vault Crypto User"
                ]
}

variable "tags" {
  description = "tags"
  type        = map(string)
}