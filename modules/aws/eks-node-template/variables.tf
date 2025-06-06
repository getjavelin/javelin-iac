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

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "eks_node_disk_size" {
  description = "EKS node disk size"
  type        = number
  default     = 50
}

variable "eks_nodegroup_sg_id" {
  description = "EKS Node Group SG ID"
  type        = string
}

variable "custom_template_properties" {
  description = "Custom launch template properties"
  type = list(object({
    name                         = string
    image_id                     = string
    block_device_name            = string
    block_device_size            = number
  }))
}

variable "k8s_cluster_name" {
  description = "K8s cluster name"
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "eks_cluster_ca_data" {
  description = "EKS cluster ca data"
  type        = string
}

variable "eks_cluster_service_cidr" {
  description = "EKS service CIDR"
  type        = string
}