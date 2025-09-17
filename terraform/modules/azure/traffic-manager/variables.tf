variable "project_env" {
  description = "Environment of deployment"
  type        = string
}

variable "project_name" {
  description = "Environment of deployment"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "appgw_ip" {
  description = "Application gw ip"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map(string)
}