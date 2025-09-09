variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "eks_cluster_sg_id" {
  description = "EKS Cluster SG ID"
  type        = string
}

variable "eks_nodegroup_sg_id" {
  description = "EKS Node Group SG ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
}

variable "eks_enabled_log_types" {
  description = "EKS cluster version"
  type        = list(string)
  # default     = []
  default     = [
                  "api",
                  "audit",
                  "authenticator",
                  "controllerManager",
                  "scheduler"
                ]
}

variable "addons" {
  description = "EKS addons"
  type = list(object({
    name    = string
    version = string
  }))
  default = [
    {
      name    = "coredns"
      version = "not-using"
    },
    {
      name    = "kube-proxy"
      version = "not-using"
    },
    {
      name    = "vpc-cni"
      version = "not-using"
    },
    {
      name    = "aws-ebs-csi-driver"
      version = "not-using"
    },
    {
      name    = "amazon-cloudwatch-observability"
      version = "not-using"
    }
  ]
}

variable "eks_cloudwatch_retention" {
  description = "Retention of CloudWatch Logs"
  type        = number
}

variable "devops_public_cidr" {
  description = "DevOps User ISP Gateway CIDR"
  type        = string
  default     = "0.0.0.0/0"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}