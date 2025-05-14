########## Locals ##########
locals {
    rds_prefix                         = join("-", ([ var.project_name, var.project_env ]))
}

########## Parameter_Group ##########
resource "aws_db_parameter_group" "rds_postgres" {
  name                                 = "${local.rds_prefix}-${var.family}-pg-grp"
  family                               = var.family

  parameter {
    name                               = "rds.force_ssl"
    value                              = "0"
  }

  parameter {
    name                               = "log_min_duration_statement"
    value                              = "100"
  }
}

########## Subnet_Group ##########
resource "aws_db_subnet_group" "rds_subnet_group" {
  name                                 = "${local.rds_prefix}-postgres-subnet-grp"
  subnet_ids                           = var.private_subnet_ids
}

########## Security_Group ##########
resource "aws_security_group" "rds_sg" {
  vpc_id                                = var.vpc_id
  name                                  = "${local.rds_prefix}-postgres-sg"
  description                           = "Security Group for RDS Traffic"
  tags                                  = {
                                            "Name" = "${local.rds_prefix}-postgres-sg"
                                          }
  lifecycle {
    create_before_destroy               = true
  }
}

resource "aws_vpc_security_group_egress_rule" "rds_internal_egress_rule" {
  ip_protocol                           = "-1"
  cidr_ipv4                             = "${var.vpc_cidr}"
  security_group_id                     = aws_security_group.rds_sg.id
  description                           = "terraform - vpc internal egress"
  tags                                  = {
                                            Name = "terraform - vpc internal egress"
                                          }
}

resource "aws_vpc_security_group_egress_rule" "rds_default_egress_rule" {
  from_port                             = var.sg_egress_from_port
  to_port                               = var.sg_egress_to_port
  ip_protocol                           = var.sg_egress_protocol
  cidr_ipv4                             = "${var.sg_egress_cidr}"
  security_group_id                     = aws_security_group.rds_sg.id
  description                           = "terraform - default egress"
  tags                                  = {
                                            Name = "terraform - default egress"
                                          }
}

resource "aws_vpc_security_group_egress_rule" "rds_default_ipv6_egress_rule" {
  count                                 = var.sg_ipv6_egress_enable == true ? 1 : 0

  from_port                             = var.sg_egress_from_port
  to_port                               = var.sg_egress_to_port
  ip_protocol                           = var.sg_egress_protocol
  cidr_ipv6                             = "${var.sg_ipv6_egress_cidr}"
  security_group_id                     = aws_security_group.rds_sg.id
  description                           = "terraform - default ipv6 egress"
  tags                                  = {
                                            Name = "terraform - default ipv6 egress"
                                          }
}

resource "aws_vpc_security_group_ingress_rule" "rds_rule" {
  from_port                             = var.psql_port
  to_port                               = var.psql_port
  ip_protocol                           = "tcp"
  cidr_ipv4                             = "${var.vpc_cidr}"
  security_group_id                     = aws_security_group.rds_sg.id
  description                           = "terraform - psql access from vpc"
  tags                                  = {
                                            Name = "terraform - psql access from vpc"
                                          }
}

########## Secret_Manager ##########
resource "aws_secretsmanager_secret" "rds_password" {
  name                                  = "${local.rds_prefix}-postgres"
  description                           = "${local.rds_prefix}-postgres"
  recovery_window_in_days               = 30
}