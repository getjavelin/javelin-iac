variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "k8s_cluster_name" {
  description = "K8s cluster name"
  type        = string
}

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
  default     = "0.0.9"
}

variable "namespace" {
  description = "Namespace for the deployment"
  type        = string
  default     = "aws-cloudwatch"
}