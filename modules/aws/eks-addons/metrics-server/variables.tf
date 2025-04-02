variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "helm_version" {
  description = "Helm Chart Version"
  type        = string
  default     = "3.12.1"
}

variable "namespace" {
  description = "Namespace for the deployment"
  type        = string
  default     = "metrics-server"
}