########## Locals ##########
locals {
    aurora_prefix                      = join("-", ([ var.project_name, var.project_env ]))
}

########## Aurora ##########
resource "aws_rds_cluster" "aurora_global" {
  cluster_identifier                    = "${local.aurora_prefix}-aurora-cluster"
  global_cluster_identifier             = var.aurora_global_cluster_identifier
  source_region                         = var.aurora_master_cluster_region
  engine_version                        = var.engine_version
  engine                                = var.engine
  db_subnet_group_name                  = var.subnet_grp
  storage_type                          = var.aurora_storage_type
  deletion_protection                   = true
  apply_immediately                     = true
  storage_encrypted                     = true
  performance_insights_enabled          = var.performance_insights_enabled
  # performance_insights_retention_period = var.performance_insights_retention_period
  performance_insights_kms_key_id       = var.kms_key_id
  kms_key_id                            = var.kms_key_id
  vpc_security_group_ids                = [ var.security_grp ]
  db_cluster_parameter_group_name       = var.cluster_parameter_grp
  preferred_maintenance_window          = var.maintenance_window
  preferred_backup_window               = var.backup_window
  backup_retention_period               = var.backup_retention_period
  skip_final_snapshot                   = var.skip_final_snapshot
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  enabled_cloudwatch_logs_exports       = [ "postgresql" ]
  port                                  = var.psql_port

  lifecycle {
    ignore_changes                      = [ replication_source_identifier ]
  }
}

resource "aws_rds_cluster_instance" "aurora_global" {
  identifier                            = "${local.aurora_prefix}-aurora-postgres"
  engine_version                        = var.engine_version
  engine                                = var.engine
  cluster_identifier                    = aws_rds_cluster.aurora_global.id
  instance_class                        = var.instance_db_class
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  apply_immediately                     = true
  publicly_accessible                   = false
  db_parameter_group_name               = var.db_parameter_grp
}

########## Secret_Manager_Data ##########
resource "aws_secretsmanager_secret_version" "aurora_password" {
  secret_id                             = var.secret_id
  secret_string                         = <<EOF
  {
    "global_cluster_id" : "${var.aurora_global_cluster_identifier}",
    "dbname"            : "",
    "engine"            : "${var.engine}",
    "username"          : "",
    "password"          : "",
    "host"              : "",
    "writer"            : "${aws_rds_cluster.aurora_global.endpoint}",
    "reader"            : "${aws_rds_cluster.aurora_global.reader_endpoint}",
    "port"              : "${aws_rds_cluster.aurora_global.port}"
  }
EOF

  lifecycle {
    ignore_changes                      = [ secret_string ]
  }
}