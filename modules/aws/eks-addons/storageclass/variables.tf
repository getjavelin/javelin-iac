variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "storage_classname" {
  description = "Javelin StorageClass"
  type        = string
}

variable "storage_provisioner" {
  description = "Javelin Storage provisioner"
  type        = string
  default     = "ebs.csi.aws.com"
}

variable "storage_type" {
  description = "Javelin Storage Type"
  type        = string
  default     = "gp3"
}

variable "fs_type" {
  description = "Javelin FS Type"
  type        = string
  default     = "ext4"
}