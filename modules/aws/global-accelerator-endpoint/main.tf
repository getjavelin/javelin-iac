########## Locals ##########
locals {
  ga_prefix                         = join("-", ([ var.project_name, var.project_env ]))
}

########## Global_Accelerator_Endpoint ##########
resource "aws_globalaccelerator_endpoint_group" "global_accelerator" {
  listener_arn                      = var.global_accelerator_listener_arn
  health_check_interval_seconds     = 30
  health_check_port                 = 443
  health_check_protocol             = "TCP"
  threshold_count                   = 3
  traffic_dial_percentage           = var.global_accelerator_traffic_percentage

  endpoint_configuration {
    client_ip_preservation_enabled  = false

    endpoint_id                     = var.alb_arn
    weight                          = 255
  }
}

