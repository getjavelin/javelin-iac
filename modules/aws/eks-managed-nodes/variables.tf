variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "eks_cluster_service_cidr" {
  description = "EKS Service CIDR"
  type        = string
}

variable "eks_cluster_primary_sg_id" {
  description = "EKS Primary SG ID"
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

variable "cluster_name" {
  description = "Cluster name"
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

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
}

variable "managed_nodes_properties" {
  description = "EKS managed nodes properties"
  type = list(object({
    name                        = string
    eks_node_ami_type           = string
    eks_node_ami_id             = string
    eks_node_instance_type      = string
    eks_node_capacity_type      = string
    eks_node_block_device_name  = string
    eks_node_block_device_size  = number
    eks_node_min_size           = number
    eks_node_max_size           = number
    enable_bootstrap_user_data  = bool
  }))
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}