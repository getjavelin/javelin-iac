variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "svc_s3_bucket_arn" {
  description = "Service S3 Bucket"
  type        = string
  default     = ""
}

variable "eks_cluster_oidc_provider_arn" {
  description = "EKS cluster oidc provider arn"
  type        = string
}

variable "eks_cluster_oidc_provider" {
  description = "EKS cluster oidc provider"
  type        = string
}

variable "svc_iam_policy_list" {
  description = "List of IAM Policies for Service"
  type        = list(string)
}