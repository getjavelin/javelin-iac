########## Locals ##########
locals {
    rds_prefix                         = join("-", ([ var.project_name, var.project_env ]))
}

########## RDS ##########
resource "aws_db_instance" "rds_postgres" {
  identifier                            = "${local.rds_prefix}-postgres"
  replicate_source_db                   = var.replicate_source_db
  instance_class                        = var.rds_instance_db_class
  port                                  = var.psql_port
  storage_type                          = var.rds_storage_type
  deletion_protection                   = true
  apply_immediately                     = true
  publicly_accessible                   = false
  storage_encrypted                     = true
  performance_insights_enabled          = var.performance_insights_enabled
  # performance_insights_retention_period = var.performance_insights_retention_period
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
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  enabled_cloudwatch_logs_exports       = [ "postgresql", "upgrade" ]

  lifecycle {
    ignore_changes                      = [ password, allocated_storage ]
  }
}