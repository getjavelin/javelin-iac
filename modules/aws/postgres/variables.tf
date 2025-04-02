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

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "rds_multi_az" {
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ."
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "family" {
  description = "Database family"
  type        = string
  default     = "postgres17"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "17.2"
}

variable "rds_instance_db_class" {
  description = "Database instance class"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "javelin_data"
}

variable "db_user" {
  description = "Postgres username"
  type        = string
  default     = "javelin"
}

variable "rds_allocated_storage" {
  description = "Allocated Storage"
  type        = number
}

variable "rds_max_allocated_storage" {
  description = "Max Allocated Storage"
  type        = number
}

variable "auto_minor_version_upgrade" {
  default     = false
  type        = bool
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:03:00-sun:05:00"
}

variable "backup_window" {
  description = "Backup window"
  type        = string
  default     = "01:00-02:30"
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "Copy tags to snapshots"
  type        = bool
  default     = true
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

variable "rds_storage_type" {
  description = "Storage Type"
  type        = string
  default     = "gp3"
}

variable "performance_insights_retention_period" {
  description = "Performance Insight Logs Retention"
  type        = number
  default     = 7
}

variable "additional_whitelist_cidr" {
  description = "Additional CIDR to whitelist"
  type        = list(string)
  default     = []
}