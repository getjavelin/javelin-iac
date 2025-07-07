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

variable "enable_self_signed_cert" {
  description = "create sample self signed certificate"
  type        = bool
}

variable "tags" {
  description = "tags"
  type        = map(string)
}