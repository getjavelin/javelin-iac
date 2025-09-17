########## Locals ##########
locals {
  ga_prefix                         = join("-", ([ var.project_name, var.project_env ]))
}

########## Global_Accelerator ##########
resource "aws_globalaccelerator_accelerator" "global_accelerator" {
  name                              = "${local.ga_prefix}-global-accelerator"
  ip_address_type                   = "IPV4"
  enabled                           = true
}

resource "aws_globalaccelerator_listener" "global_accelerator" {
  accelerator_arn                   = aws_globalaccelerator_accelerator.global_accelerator.arn
  client_affinity                   = "SOURCE_IP"
  protocol                          = "TCP"

  port_range {
    from_port                       = 80
    to_port                         = 80
  }

  port_range {
    from_port                       = 443
    to_port                         = 443
  }
}