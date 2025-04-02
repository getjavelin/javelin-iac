variable "project_env" {
  description = "Project environment"
  type        = string
}

variable "project_name"{
  description = "Project name"
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

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "engine" {
  description = "Cache engine"
  type        = string
  default = "redis"
}

variable "engine_version" {
  description = "Redis engine version"
  type        = string
  default = "7.1"
}

variable "family" {
  description = "Redis family"
  type        = string
  default     = "redis7"
}

variable "redis_node_type" {
  description = "Cache instance class"
  type        = string
}

variable "auto_minor_version_upgrade" {
  default     = false
  type        = bool
  description = "Indicates that minor engine upgrades will be applied automatically to the cache instance during the maintenance window"
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:03:00-sun:05:00"
}

variable "snapshot_window" {
  description = "Snapshot window"
  type        = string
  default     = "01:00-02:30"
}

variable "snapshot_retention_limit" {
  description = "Snapshot retention period in days"
  type        = number
  default     = 5
}

variable "redis_port" {
  description = "Redis Port"
  type        = number
  default     = 6379
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

variable "redis_cloudwatch_retention" {
  description = "Cloudwatch log retention"
  type        = number
  default     = 30
}

variable "additional_whitelist_cidr" {
  description = "Additional CIDR to whitelist"
  type        = list(string)
  default     = []
}