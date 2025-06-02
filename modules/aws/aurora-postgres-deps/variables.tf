variable "project_env" {
  description = "Project environment"
  type        = string
}

variable "project_name" {
  description = "Project environment"
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

variable "family" {
  description = "Aurora family"
  type        = string
  default     = "aurora-postgresql16"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "psql_port" {
  description = "PSQL Port"
  type        = number
  default     = 5432
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

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}