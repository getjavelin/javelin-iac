########## Locals ##########
locals {
  sg_prefix  = join("-", ([ var.project_name, var.project_env ]))
}

########## Security_Group ##########
resource "aws_security_group" "alb_fe_sg" {
  vpc_id      = var.vpc_id
  name        = "${local.sg_prefix}-alb-fe-sg"
  description = "Security Group for ALB FE Traffic"

  tags = {
    "Name" = "${local.sg_prefix}-alb-fe-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "alb_fe_internal_egress_rule" {
  # from_port         = 0
  # to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "${var.vpc_cidr}"
  security_group_id = aws_security_group.alb_fe_sg.id
  description       = "terraform - vpc internal egress"
  tags = {
    Name = "terraform - vpc internal egress"
  }
}

# resource "aws_vpc_security_group_egress_rule" "alb_fe_default_egress_rule" {
#   from_port         = var.sg_egress_from_port
#   to_port           = var.sg_egress_to_port
#   ip_protocol       = var.sg_egress_protocol
#   cidr_ipv4         = "${var.sg_egress_cidr}"
#   security_group_id = aws_security_group.alb_fe_sg.id
#   description       = "terraform - default egress"
#   tags = {
#     Name = "terraform - default egress"
#   }
# }

# resource "aws_vpc_security_group_egress_rule" "alb_fe_default_ipv6_egress_rule" {
#   count             = var.sg_ipv6_egress_enable == true ? 1 : 0

#   from_port         = var.sg_egress_from_port
#   to_port           = var.sg_egress_to_port
#   ip_protocol       = var.sg_egress_protocol
#   cidr_ipv6         = "${var.sg_ipv6_egress_cidr}"
#   security_group_id = aws_security_group.alb_fe_sg.id
#   description       = "terraform - default ipv6 egress"
#   tags = {
#     Name = "terraform - default ipv6 egress"
#   }
# }

resource "aws_vpc_security_group_ingress_rule" "alb_fe_http_rule" {
  from_port         = var.http_port
  to_port           = var.http_port
  ip_protocol       = "tcp"
  cidr_ipv4         = "${var.alb_access_cidr}"
  security_group_id = aws_security_group.alb_fe_sg.id
  description       = "terraform - http access to alb"
  tags = {
    Name = "terraform - http access to alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_fe_https_rule" {
  from_port         = var.https_port
  to_port           = var.https_port
  ip_protocol       = "tcp"
  cidr_ipv4         = "${var.alb_access_cidr}"
  security_group_id = aws_security_group.alb_fe_sg.id
  description       = "terraform - https access to alb"
  tags = {
    Name = "terraform - https access to alb"
  }
}

resource "aws_security_group" "alb_be_sg" {
  vpc_id      = var.vpc_id
  name        = "${local.sg_prefix}-alb-be-sg"
  description = "Security Group for ALB BE Traffic"

  tags = {
    "Name" = "${local.sg_prefix}-alb-be-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "alb_be_internal_egress_rule" {
  # from_port         = 0
  # to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "${var.vpc_cidr}"
  security_group_id = aws_security_group.alb_be_sg.id
  description       = "terraform - vpc internal egress"
  tags = {
    Name = "terraform - vpc internal egress"
  }
}

# resource "aws_vpc_security_group_egress_rule" "alb_be_default_egress_rule" {
#   from_port         = var.sg_egress_from_port
#   to_port           = var.sg_egress_to_port
#   ip_protocol       = var.sg_egress_protocol
#   cidr_ipv4         = "${var.sg_egress_cidr}"
#   security_group_id = aws_security_group.alb_be_sg.id
#   description       = "terraform - default egress"
#   tags = {
#     Name = "terraform - default egress"
#   }
# }

# resource "aws_vpc_security_group_egress_rule" "alb_be_default_ipv6_egress_rule" {
#   count             = var.sg_ipv6_egress_enable == true ? 1 : 0

#   from_port         = var.sg_egress_from_port
#   to_port           = var.sg_egress_to_port
#   ip_protocol       = var.sg_egress_protocol
#   cidr_ipv6         = "${var.sg_ipv6_egress_cidr}"
#   security_group_id = aws_security_group.alb_be_sg.id
#   description       = "terraform - default ipv6 egress"
#   tags = {
#     Name = "terraform - default ipv6 egress"
#   }
# }

resource "aws_vpc_security_group_ingress_rule" "alb_eks_access_rule" {
  from_port                    = 30000
  to_port                      = 32767
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb_be_sg.id
  security_group_id            = var.eks_node_security_group_id
  description                  = "terraform - eks access from alb"
  tags = {
    Name = "terraform - eks access from alb"
  }
}