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

variable "tenant_id" {
  description = "tenant id"
  type        = string
}

variable "des_keyvault_role_list" {
  description = "DES Role List"
  type        = list(string)
  default     = [
                  "Contributor",
                  "Key Vault Crypto User"
                ]
}

variable "tags" {
  description = "tags"
  type        = map(string)
}