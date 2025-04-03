variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template ID"
  type        = string
}

variable "launch_template_version" {
  description = "Launch Template Version"
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

variable "cluster_version" {
  description = "Cluster version"
  type        = string
}

variable "custom_nodes_properties" {
  description = "EKS custom nodes properties"
  type = list(object({
    name                     = string
    eks_node_ami_type        = string
    eks_node_instance_type   = string
    eks_node_capacity_type   = string
    eks_node_min_size        = number
    eks_node_max_size        = number
  }))
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}