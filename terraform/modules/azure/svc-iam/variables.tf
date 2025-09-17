variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
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

variable "aks_oidc_issuer_url" {
  description = "AKS oidc issuer url"
  type        = string
}

variable "app_role_list" {
  description = "App Role List"
  type        = list(string)
  default     = [
                  "Key Vault Secrets Officer"
                ]
}

variable "workload_identity" {
  description = "workload identity map of namespace and ksa"
  type = list(object({
    id             = number
    namespace      = string
    serviceaccount = string
  }))
}

variable "tags" {
  description = "tags"
  type        = map(string)
}