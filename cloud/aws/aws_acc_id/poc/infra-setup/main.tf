data "aws_caller_identity" "current" {}

locals {
  aws_account_id                          = data.aws_caller_identity.current.account_id
  tags                                    = merge(var.common_tags,
                                                {
                                                  Project       = var.project_name
                                                  Environment   = var.project_env
                                                })
}

module "vpc" {
  count                                   = var.enable_vpc == true ? 1 : 0
  source                                  = "../../../../../modules/aws/vpc"
  project_name                            = var.project_name
  project_env                             = var.project_env
  vpc_cidr                                = var.vpc_cidr
  azs                                     = var.azs
  public_subnets                          = var.public_subnets
  private_subnets                         = var.private_subnets
  database_subnets                        = var.database_subnets
}

module "postgres_deps" {
  count                                   = var.enable_postgres_deps == true ? 1 : 0
  depends_on                              = [ module.vpc ]
  source                                  = "../../../../../modules/aws/postgres-deps"
  vpc_cidr                                = var.vpc_cidr
  project_name                            = var.project_name
  project_env                             = var.project_env
  sg_egress_from_port                     = var.sg_egress_from_port
  sg_egress_to_port                       = var.sg_egress_to_port
  sg_egress_protocol                      = var.sg_egress_protocol
  sg_egress_cidr                          = var.sg_egress_cidr
  sg_ipv6_egress_enable                   = var.sg_ipv6_egress_enable
  sg_ipv6_egress_cidr                     = var.sg_ipv6_egress_cidr
  vpc_id                                  = module.vpc[0].vpc_id
  aws_account_id                          = local.aws_account_id
  private_subnet_ids                      = module.vpc[0].private_subnet_ids
}

module "postgres_primary" {
  count                                   = var.enable_postgres_primary == true ? 1 : 0
  depends_on                              = [ module.vpc ]
  source                                  = "../../../../../modules/aws/postgres-primary"
  rds_multi_az                            = var.rds_multi_az
  project_name                            = var.project_name
  project_env                             = var.project_env
  rds_instance_db_class                   = var.rds_instance_db_class
  rds_allocated_storage                   = var.rds_allocated_storage
  rds_max_allocated_storage               = var.rds_max_allocated_storage
  kms_key_id                              = module.postgres_deps[0].postgres_kms_key
  secret_id                               = module.postgres_deps[0].postgres_secret_arn
  parameter_grp                           = module.postgres_deps[0].postgres_pramas_grp
  security_grp                            = module.postgres_deps[0].postgres_security_grp
  subnet_grp                              = module.postgres_deps[0].postgres_subnet_grp
}

module "postgres_secondary" {
  count                                   = var.enable_postgres_secondary == true ? 1 : 0
  source                                  = "../../../../../modules/aws/postgres-secondary"
  rds_multi_az                            = var.rds_multi_az
  project_name                            = var.project_name
  project_env                             = var.project_env
  replicate_source_db                     = var.rds_replicate_source_db
  rds_instance_db_class                   = var.rds_instance_db_class
  kms_key_id                              = module.postgres_deps[0].postgres_kms_key
  parameter_grp                           = module.postgres_deps[0].postgres_pramas_grp
  security_grp                            = module.postgres_deps[0].postgres_security_grp
  subnet_grp                              = module.postgres_deps[0].postgres_subnet_grp
}

module "psql_seeding" {
  count                                   = var.enable_psql_seeding == true ? 1 : 0
  source                                  = "../../../../../modules/aws/psql-seeding"
  project_name                            = var.project_name
  project_env                             = var.project_env
  psql_seeding_file                       = var.psql_seeding_file
  psql_host                               = module.postgres_primary[0].postgres_host
  psql_port                               = module.postgres_primary[0].postgres_port
  psql_database                           = module.postgres_primary[0].db_name
  psql_username                           = module.postgres_primary[0].db_user
  psql_password                           = module.postgres_primary[0].db_pass
}

module "redis" {
  count                                   = var.enable_redis == true ? 1 : 0
  depends_on                              = [ module.vpc ]
  source                                  = "../../../../../modules/aws/redis"
  vpc_cidr                                = var.vpc_cidr
  project_name                            = var.project_name
  project_env                             = var.project_env
  redis_node_type                         = var.redis_node_type
  sg_egress_from_port                     = var.sg_egress_from_port
  sg_egress_to_port                       = var.sg_egress_to_port
  sg_egress_protocol                      = var.sg_egress_protocol
  sg_egress_cidr                          = var.sg_egress_cidr
  sg_ipv6_egress_enable                   = var.sg_ipv6_egress_enable
  sg_ipv6_egress_cidr                     = var.sg_ipv6_egress_cidr
  vpc_id                                  = module.vpc[0].vpc_id
  private_subnet_ids                      = module.vpc[0].private_subnet_ids
}

module "eks_sg" {
  count                                   = var.enable_eks == true ? 1 : 0
  source                                  = "../../../../../modules/aws/eks-sg"
  project_name                            = var.project_name
  project_env                             = var.project_env
  vpc_cidr                                = var.vpc_cidr
  sg_egress_from_port                     = var.sg_egress_from_port
  sg_egress_to_port                       = var.sg_egress_to_port
  sg_egress_protocol                      = var.sg_egress_protocol
  sg_egress_cidr                          = var.sg_egress_cidr
  sg_ipv6_egress_enable                   = var.sg_ipv6_egress_enable
  sg_ipv6_egress_cidr                     = var.sg_ipv6_egress_cidr
  custom_egress_port_list                 = var.custom_egress_port_list
  vpc_id                                  = module.vpc[0].vpc_id
}

module "eks" {
  count                                   = var.enable_eks == true ? 1 : 0
  source                                  = "../../../../../modules/aws/eks"
  aws_account_id                          = local.aws_account_id
  project_name                            = var.project_name
  project_env                             = var.project_env
  region                                  = var.region
  eks_cluster_version                     = var.eks_cluster_version
  eks_cloudwatch_retention                = var.eks_cloudwatch_retention
  common_tags                             = local.tags
  vpc_id                                  = module.vpc[0].vpc_id
  private_subnet_ids                      = module.vpc[0].private_subnet_ids
  eks_cluster_sg_id                       = module.eks_sg[0].eks_cluster_sg_id
  eks_nodegroup_sg_id                     = module.eks_sg[0].eks_nodegroup_sg_id
}

module "eks_custom_nodes" {
  count                                   = var.enable_eks == true ? 1 : 0
  source                                  = "../../../../../modules/aws/eks-custom-nodes"
  project_name                            = var.project_name
  project_env                             = var.project_env
  cluster_version                         = var.eks_cluster_version
  custom_nodes_properties                 = var.eks_custom_nodes_properties
  common_tags                             = local.tags
  launch_template_id                      = module.eks[0].eks_node_launch_template_id
  launch_template_version                 = module.eks[0].eks_node_launch_template_version
  eks_cluster_service_cidr                = module.eks[0].eks_cluster_service_cidr
  eks_cluster_primary_sg_id               = module.eks[0].eks_cluster_primary_sg_id
  cluster_name                            = module.eks[0].k8s_cluster_name
  private_subnet_ids                      = module.vpc[0].private_subnet_ids
  eks_nodegroup_sg_id                     = module.eks_sg[0].eks_nodegroup_sg_id
}

module "alb_sg" {
  count                                   = var.enable_alb_sg == true ? 1 : 0
  source                                  = "../../../../../modules/aws/alb-sg"
  project_name                            = var.project_name
  project_env                             = var.project_env
  vpc_cidr                                = var.vpc_cidr
  alb_access_cidr                         = var.alb_access_cidr
  sg_egress_from_port                     = var.sg_egress_from_port
  sg_egress_to_port                       = var.sg_egress_to_port
  sg_egress_protocol                      = var.sg_egress_protocol
  sg_egress_cidr                          = var.sg_egress_cidr
  sg_ipv6_egress_enable                   = var.sg_ipv6_egress_enable
  sg_ipv6_egress_cidr                     = var.sg_ipv6_egress_cidr
  vpc_id                                  = module.vpc[0].vpc_id
  eks_node_security_group_id              = module.eks_sg[0].eks_nodegroup_sg_id
}

module "svc_iam" {
  count                                   = var.enable_svc_iam == true ? 1 : 0
  source                                  = "../../../../../modules/aws/svc-iam"
  project_name                            = var.project_name
  project_env                             = var.project_env
  svc_iam_policy_list                     = var.svc_iam_policy_list
  eks_cluster_oidc_provider               = module.eks[0].eks_cluster_oidc_provider
  eks_cluster_oidc_provider_arn           = module.eks[0].eks_cluster_oidc_provider_arn
}

module "svc_kms" {
  count                                   = var.enable_svc_kms == true ? 1 : 0
  source                                  = "../../../../../modules/aws/svc-kms"
  project_name                            = var.project_name
  project_env                             = var.project_env
  aws_account_id                          = local.aws_account_id
  svc_iam_role_arn                        = module.svc_iam[0].iam_role_arn
}