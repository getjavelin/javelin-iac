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

variable "des_id" {
  description = "DES id"
  type        = string
}

variable "aks_version" {
  description = "aks version"
  type        = string
}

variable "application_gw_id" {
  description = "application gw id"
  type        = string
}

variable "application_gw_identity_id" {
  description = "application gw identity id"
  type        = string
}

variable "aks_authorized_networks" {
  description = "aks authorized networks"
  type        = list(string)
}

variable "tenant_id" {
  description = "tenant id"
  type        = string
}

variable "aks_auth_object_ids" {
  description = "aks auth object ids"
  type        = list(string)
}

variable "aks_default_node_vm_size" {
  description = "aks default node vm size"
  type        = string
}

variable "private_subnet_id" {
  description = "private subnet id"
  type        = string
}

variable "appgw_subnet_id" {
  description = "app gw subnet id"
  type        = string
}

variable "aks_service_cidr" {
  description = "aks service cidr"
  type        = string
}

variable "aks_dns_service_ip" {
  description = "aks dns service ip"
  type        = string
}

variable "aks_log_retention_in_days" {
  description = "AKS log retention days"
  type        = number
}

variable "log_stream_list" {
  type    = list(string)
  default = [
    "Microsoft-ContainerLog",
    "Microsoft-ContainerLogV2",
    "Microsoft-KubeEvents",
    "Microsoft-KubePodInventory",
    "Microsoft-KubeNodeInventory",
    "Microsoft-KubePVInventory",
    "Microsoft-KubeServices",
    "Microsoft-KubeMonAgentEvents",
    "Microsoft-InsightsMetrics",
    "Microsoft-ContainerInventory",
    "Microsoft-ContainerNodeInventory",
    "Microsoft-Perf"
  ]
}

variable "tags" {
  description = "tags"
  type        = map(string)
}