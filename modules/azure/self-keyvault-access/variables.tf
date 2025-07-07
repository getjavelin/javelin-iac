variable "ad_object_id" {
  description = "AD object ID for user or group"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "self_keyvault_role_list" {
  description = "Self KeyVault Role List"
  type        = list(string)
  default     = [
                  "Contributor",
                  "Key Vault Crypto User",
                  "Key Vault Secrets User",
                  "Key Vault Certificates Officer"
                ]
}