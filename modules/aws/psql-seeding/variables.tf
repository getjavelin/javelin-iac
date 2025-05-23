variable "project_env" {
  description = "Environment of deployment"
  type        = string
}

variable "project_name" {
  description = "Environment of deployment"
  type        = string
}

variable "remote_exec" {
  description = "Whether this psql execution is local or remote over bastion host"
  type        = bool
  default     = false
}

variable "bastion_ip" {
  description = "bastion IP for accessing from local"
  type        = string
  default     = ""
}

variable "bastion_user" {
  description = "bastion ssh user for accessing from local"
  type        = string
  default     = ""
}

variable "local_ssh_key" {
  description = "ssh key for bastion host access from local"
  type        = string
  default     = ""
}

variable "psql_seeding_file" {
  description = "Postgres SQL Script name"
  type        = string
}

variable "psql_host" {
  description = "Postgres Host"
  type        = string
}

variable "psql_port" {
  description = "Postgres Port"
  type        = string
}

variable "psql_database" {
  description = "Postgres Database"
  type        = string
}

variable "psql_username" {
  description = "Postgres Username"
  type        = string
}

variable "psql_password" {
  description = "Postgres Password"
  type        = string
}

variable "psql_sslmode" {
  description = "Postgres SSL Mode"
  type        = string
  default     = "false"
}

variable "javelin_customers_password" {
  description = "javelin_customers password"
  type        = string
  default     = ""
}

variable "javelin_admin_password" {
  description = "javelin_admin password"
  type        = string
  default     = ""
}