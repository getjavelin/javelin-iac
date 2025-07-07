variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment Name"
  type        = string
}

variable "storage_classname" {
  description = "Javelin StorageClass"
  type        = string
}

variable "storage_provisioner" {
  description = "Javelin Storage provisioner"
  type        = string
  default     = "disk.csi.azure.com"
}

variable "storage_sku" {
  description = "Javelin Storage sku"
  type        = string
  default     = "Premium_LRS"
}

variable "des_id" {
  description = "DES ID"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}