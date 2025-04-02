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

variable "bastion_sg_id" {
  description = "Bastion SG ID"
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

variable "https_port" {
  description = "HTTPS Port Number"
  type        = number
  default     = 443
}

variable "additional_whitelist_cidr" {
  description = "Additional CIDR to whitelist"
  type        = list(string)
  default     = []
}