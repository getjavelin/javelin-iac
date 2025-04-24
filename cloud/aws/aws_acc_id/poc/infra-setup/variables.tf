variable "bucket" {
  description = "StateFile Backend S3 Name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "project_env" {
  description = "Project Env"
  type        = string
}

variable "enable_vpc" {
  description = "enable vpc"
  type        = bool
}

variable "enable_postgres" {
  description = "enable postgres"
  type        = bool
}

variable "enable_redis" {
  description = "enable redis"
  type        = bool
}

variable "enable_eks" {
  description = "enable eks"
  type        = bool
}

variable "enable_alb_sg" {
  description = "enable alb sg"
  type        = bool
}

variable "enable_svc_iam" {
  description = "enable svc iam"
  type        = bool
}

variable "enable_svc_kms" {
  description = "enable svc kms"
  type        = bool
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
}

variable "redis_node_type" {
  description = "Cache instance class"
  type        = string
}

variable "rds_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = false
}

variable "rds_instance_db_class" {
  description = "Database instance class"
  type        = string
}

variable "svc_iam_policy_list" {
  description = "List of IAM Policies for Service"
  type        = list(string)
  default     = [
                  "arn:aws:iam::aws:policy/AmazonBedrockFullAccess",
                  "arn:aws:iam::aws:policy/AWSCloudTrail_ReadOnlyAccess",
                  "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
                  "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
                ]
}

variable "eks_cloudwatch_retention" {
  description = "Retention of CloudWatch Logs"
  type        = number
}

variable "rds_allocated_storage" {
  description = "Allocated Storage"
  type        = number
  default     = 50
}

variable "rds_max_allocated_storage" {
  description = "Max Allocated Storage"
  type        = number
  default     = 512
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
}

variable "eks_custom_nodes_properties" {
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

variable "alb_access_cidr" {
  description = "ALB Access CIDR Block"
  type        = string
  default     = "0.0.0.0/0"
}

variable "sg_egress_from_port" {
  description = "Default Egress from Port"
  type        = number
  default     = 443
}

variable "sg_egress_to_port" {
  description = "Default Egress to Port"
  type        = number
  default     = 443
}

variable "sg_egress_protocol" {
  description = "Default Egress Protocol"
  type        = string
  default     = "tcp"
}

variable "sg_egress_cidr" {
  description = "Default Egress cidr"
  type        = string
  default     = "0.0.0.0/0"
}

variable "sg_ipv6_egress_enable" {
  description = "Enable Egress ipv6 cidr"
  type        = bool
  default     = true
}

variable "sg_ipv6_egress_cidr" {
  description = "Default Egress ipv6 cidr"
  type        = string
  default     = "::/0"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "custom_egress_port_list" {
  description = "Custom Egress port list for enabling outbound connectivity"
  type        = list(string)
  default     = []
}