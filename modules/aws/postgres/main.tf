########## Locals ##########
locals {
    rds_prefix                         = join("-", ([ var.project_name, var.project_env ]))
}

########## Random_Pass ##########
resource "random_password" "rds_password" {
  length                               = 16
  special                              = false
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

resource "aws_vpc_security_group_ingress_rule" "additional_rds_rule" {
  for_each                              = toset(var.additional_whitelist_cidr)

  from_port                             = var.psql_port
  to_port                               = var.psql_port
  ip_protocol                           = "tcp"
  cidr_ipv4                             = "${each.value}"
  security_group_id                     = aws_security_group.rds_sg.id
  description                           = "terraform - psql access from ${each.value}"
  tags                                  = {
                                            Name = "terraform - psql access from ${each.value}"
                                          }
}

########## RDS ##########
resource "aws_db_instance" "rds_postgres" {
  identifier                            = "${local.rds_prefix}-postgres"
  engine                                = var.engine
  engine_version                        = var.engine_version
  instance_class                        = var.rds_instance_db_class
  port                                  = var.psql_port
  db_name                               = var.db_name
  username                              = var.db_user
  password                              = random_password.rds_password.result
  storage_type                          = var.rds_storage_type
  allocated_storage                     = var.rds_allocated_storage
  max_allocated_storage                 = var.rds_max_allocated_storage
  deletion_protection                   = true
  apply_immediately                     = true
  storage_encrypted                     = true
  publicly_accessible                   = false
  performance_insights_enabled          = true
  performance_insights_retention_period = var.performance_insights_retention_period
  db_subnet_group_name                  = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids                = [ aws_security_group.rds_sg.id ]
  parameter_group_name                  = aws_db_parameter_group.rds_postgres.name
  multi_az                              = var.rds_multi_az
  maintenance_window                    = var.maintenance_window
  backup_window                         = var.backup_window
  backup_retention_period               = var.backup_retention_period
  skip_final_snapshot                   = var.skip_final_snapshot
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  enabled_cloudwatch_logs_exports       = [ "postgresql", "upgrade" ]

  lifecycle {
    ignore_changes                      = [ password, allocated_storage ]
  }
}

########## Random_Pass_javelin_customers ##########
resource "random_password" "javelin_customers_password" {
  length                                = 16
  special                               = false
}

########## Random_Pass_javelin_admins ##########
resource "random_password" "javelin_admins_password" {
  length                                = 16
  special                               = false
}

########## Secret_manager ##########
resource "aws_secretsmanager_secret" "rds_password" {
  name                                  = "${local.rds_prefix}-postgres"
  recovery_window_in_days               = 30
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  depends_on                            = [ aws_db_instance.rds_postgres ]
  secret_id                             = aws_secretsmanager_secret.rds_password.id
  secret_string                         = <<EOF
  {
    "dbname"            : "${aws_db_instance.rds_postgres.db_name}",
    "engine"            : "${aws_db_instance.rds_postgres.engine}",
    "username"          : "${aws_db_instance.rds_postgres.username}",
    "password"          : "${random_password.rds_password.result}",
    "javelin_customers" : "${random_password.javelin_customers_password.result}",
    "javelin_admins"    : "${random_password.javelin_admins_password.result}",
    "host"              : "${aws_db_instance.rds_postgres.address}",
    "port"              : "${aws_db_instance.rds_postgres.port}",
    "arn"               : "${aws_db_instance.rds_postgres.arn}"
  }
EOF
  lifecycle {
    ignore_changes                      = [ secret_string ]
  }
}