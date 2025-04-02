variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "region" {
  type        = string
  description = "AWS region where secrets are stored."
}

variable "helm_version" {
  type        = string
  default     = "9.32.1"
  description = "Cluster Autoscaler Helm chart version."
}

variable "namespace" {
  type        = string
  default     = "cluster-autoscaler"
  description = "Kubernetes namespace to deploy Cluster Autoscaler Helm chart."
}

variable "service_account_name" {
  type        = string
  default     = "cluster-autoscaler"
  description = "Cluster Autoscaler service account name"
}

variable "mod_dependency" {
  default     = null
  description = "Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable."
}

variable "k8s_cluster_name" {
  type        = string
  description = "K8s Cluster Name"
}

variable "eks_cluster_oidc_provider" {
  type        = string
  description = "The OIDC Identity issuer for the cluster."
}

variable "eks_cluster_oidc_provider_arn" {
  type        = string
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account."
}
