variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Environment stage"
  type        = string
}

variable "global_accelerator_listener_arn" {
  description = "global accelerator listener arn"
  type        = string
}

variable "alb_arn" {
  description = "ALB arn"
  type        = string
}

variable "global_accelerator_traffic_percentage" {
  description = "Traffic percentage to the the ALB"
  type        = number
}