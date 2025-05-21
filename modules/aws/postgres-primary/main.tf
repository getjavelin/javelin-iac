########## Locals ##########
locals {
    rds_prefix                         = join("-", ([ var.project_name, var.project_env ]))
}

########## Random_Pass ##########
resource "random_password" "rds_password" {
  length                               = 16
  special                              = false
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
  performance_insights_kms_key_id       = var.kms_key_id
  kms_key_id                            = var.kms_key_id
  db_subnet_group_name                  = var.subnet_grp
  vpc_security_group_ids                = [ var.security_grp ]
  parameter_group_name                  = var.parameter_grp
  multi_az                              = var.rds_multi_az
  maintenance_window                    = var.maintenance_window
  backup_window                         = var.backup_window
  backup_retention_period               = var.backup_retention_period
  skip_final_snapshot                   = var.skip_final_snapshot
  snapshot_identifier                   = ""
  final_snapshot_identifier             = "${local.rds_prefix}-postgres-final"
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  enabled_cloudwatch_logs_exports       = [ "postgresql", "upgrade" ]

  lifecycle {
    ignore_changes                      = [ password, allocated_storage, snapshot_identifier ]
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

########## Secret_Manager_Data ##########
resource "aws_secretsmanager_secret_version" "rds_password" {
  depends_on                            = [ aws_db_instance.rds_postgres ]
  secret_id                             = var.secret_id
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