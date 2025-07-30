variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "cert_acme_email" {
  description = "email for ACME Registration"
  type        = string
}

variable "helm_version" {
  description = "Helm Chart Version"
  type        = string
  default     = "1.14.5"
}

variable "namespace" {
  description = "Namespace for the deployment"
  type        = string
  default     = "cert-manager"
}