variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment Name"
  type        = string
}

variable "helm_version" {
  description = "Helm Chart Version"
  type        = string
  default     = "25.20.1"
}

variable "namespace" {
  description = "Namespace for the deployment"
  type        = string
}

variable "service_namespace" {
  description = "Javelin Deployment namespace"
  type        = string
}

variable "storage_classname" {
  description = "Javelin StorageClass"
  type        = string
}

variable "prometheus_disk_size" {
  description = "Prometheus Disk size"
  type        = string
}

variable "prometheus_helm_value_file" {
  description = "Prometheus Helm Value File"
  type        = string
  default     = "prometheus-values.yml"
}