variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
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

# variable "bastion_sg_id" {
#   description = "Bastion SG ID"
#   type        = string
# }

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

variable "tags" {
  description = "All Tags"
  type = object({
    eks       = map(any)
    eks_addon = map(any)
    iam_role  = map(any)

  })
  default = {
    eks       = {}
    eks_addon = {}
    iam_role  = {}
  }
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
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

variable "bastion_role_name" {
  description = "Bastion Role Name"
  type        = string
}

variable "eks_cloudwatch_retention" {
  description = "Retention of CloudWatch Logs"
  type        = number
}

variable "eks_demand_node_group_enable" {
  description = "Enable on_demand node group"
  type        = bool
  default     = false
}

variable "eks_demand_node_min_size" {
  description = "Minimum number of on_demand nodes in EKS"
  type        = number
  default     = 1
}

variable "eks_demand_node_max_size" {
  description = "Maximum number of on_demand nodes in EKS"
  type        = number
  default     = 3
}

variable "eks_demand_node_instance_type" {
  description = "Instance type for on_demand nodes"
  type        = string
  default     = "t3.medium"
}

variable "eks_spot_node_group_enable" {
  description = "Enable spot node group"
  type        = bool
  default     = false
}

variable "eks_spot_node_min_size" {
  description = "Minimum number of spot nodes in EKS"
  type        = number
  default     = 1
}

variable "eks_spot_node_max_size" {
  description = "Maximum number of spot nodes in EKS"
  type        = number
  default     = 3
}

variable "eks_spot_node_instance_type" {
  description = "Instance type spot nodes"
  type        = string
  default     = "t3.medium"
}

variable "eks_node_ami_type" {
  description = "EKS node ami type"
  type        = string
  default     = "AL2_x86_64"
}

variable "eks_node_disk_size" {
  description = "EKS node disk size"
  type        = number
  default     = 50
}

variable "devops_public_cidr" {
  description = "DevOps User ISP Gateway CIDR"
  type        = string
  default     = "0.0.0.0/0"
}