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

variable "ssl_keyvault_id" {
  description = "ssl key vault id"
  type        = string
}

variable "ssl_keyvault_secret_ids" {
  description = "List of SSL certificates stored in keyvault"
  type        = list(object({
    name                = string
    keyvault_secret_id  = string
  }))
}

variable "appgw_keyvault_role_list" {
  description = "App GW Role List"
  type        = list(string)
  default     = [
                  "Contributor",
                  "Key Vault Certificates Officer",
                  "Key Vault Secrets User"
                ]
}

variable "appgw_subnet_id" {
  description = "app gw subnet id"
  type        = string
}

variable "appgw_zones" {
  description = "appgw zones"
  type        = list(string)
  default     = [ "1", "2", "3" ]
}

variable "tags" {
  description = "tags"
  type        = map(string)
}