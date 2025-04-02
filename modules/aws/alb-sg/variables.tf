variable "project_env" {
  description = "Environment of deployment"
  type        = string
}

variable "project_name" {
  description = "Environment of deployment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "alb_access_cidr" {
  description = "ALB Access CIDR Block"
  type        = string
}

variable "sg_egress_from_port" {
  description = "Default Egress from Port"
  type        = number
}

variable "sg_egress_to_port" {
  description = "Default Egress to Port"
  type        = number
}

variable "sg_egress_protocol" {
  description = "Default Egress Protocol"
  type        = string
}

variable "sg_egress_cidr" {
  description = "Default Egress cidr"
  type        = string
}

variable "sg_ipv6_egress_enable" {
  description = "Enable Egress ipv6 cidr"
  type        = bool
}

variable "sg_ipv6_egress_cidr" {
  description = "Default Egress ipv6 cidr"
  type        = string
}

variable "http_port" {
  description = "HTTP Port Number"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "HTTPS Port Number"
  type        = number
  default     = 443
}

variable "eks_node_security_group_id" {
  description = "EKS NodeGroup SG ID"
  type        = string
}