variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment Name"
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

variable "aks_cluster_id" {
  description = "AKS cluster id"
  type        = string
}

variable "private_subnet_id" {
  description = "private subnet id"
  type        = string
}

variable "aks_node_disk_size" {
  description = "AKS node disk size"
  type        = number
  default     = 100
}

variable "aks_nodes_properties" {
  description = "AKS cpu nodes properties"
  type = list(object({
    name                     = string
    aks_node_vm_size         = string
    aks_node_priority        = string
    aks_node_min_count       = number
    aks_node_max_count       = number
  }))
}

variable "tags" {
  description = "tags"
  type        = map(string)
}