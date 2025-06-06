## Terraform Backend Variables
bucket                                   = "javelin-tf-poc"
## Enable required services
enable_vpc                               = false
enable_postgres_deps                     = false
enable_postgres_primary                  = false
enable_postgres_secondary                = false
enable_psql_seeding                      = false
enable_redis                             = false
enable_eks                               = false
enable_eks_custom_nodes                  = false
enable_alb_sg                            = false
enable_svc_iam                           = false
enable_svc_kms                           = false
enable_global_accelerator                = false
enable_global_accelerator_endpoint       = false
enable_aurora_postgres_deps              = false
enable_aurora_postgres_primary           = false
enable_aurora_postgres_secondary         = false
## Resource Variables
common_tags                              = {
                                               ManagedBy   = "Terraform"
                                            }
region                                   = "us-east-1"
project_name                             = "javelin"
project_env                              = "poc"
vpc_cidr                                 = "10.1.0.0/16" # Mask must be /16
azs                                      = [
                                                "us-east-1a",
                                                "us-east-1b",
                                                "us-east-1c"
                                            ]
public_subnets                           = [
                                                "10.1.0.0/20",
                                                "10.1.16.0/20",
                                                "10.1.32.0/20"
                                            ]
private_subnets                          = [
                                                "10.1.48.0/20",
                                                "10.1.64.0/20",
                                                "10.1.80.0/20"
                                            ]
database_subnets                         = [
                                                "10.1.96.0/20",
                                                "10.1.112.0/20",
                                                "10.1.128.0/20"
                                            ]
redis_node_type                          = "cache.m5.large"
rds_instance_db_class                    = "db.m5.large"
aurora_instance_db_class                 = "db.r6g.large"
aurora_master_cluster_region             = "us-east-1"
aurora_global_cluster_identifier         = ""
pg_db_list                               = []
pg_extentions                            = []
rds_replicate_source_db                  = ""
eks_cloudwatch_retention                 = 30
eks_cluster_version                      = "1.32"
eks_custom_template_properties           = [
                                                {
                                                    name                           = "generic"
                                                    image_id                       = ""
                                                    block_device_name              = "/dev/xvda"
                                                    block_device_size              = 50
                                                }
                                            ]
eks_custom_nodes_properties              = [
                                                {
                                                    name                           = "general"
                                                    eks_cluster_version            = "1.32" # "" for CUSTOM eks_node_ami_type
                                                    eks_node_ami_type              = "AL2023_x86_64_STANDARD" # CUSTOM
                                                    eks_node_instance_type         = "c5.4xlarge"
                                                    eks_node_capacity_type         = "ON_DEMAND" # ON_DEMAND or SPOT
                                                    eks_launch_template_id         = "lt-aaaaaaaaaaaa"
                                                    eks_launch_template_version    = 1
                                                    eks_node_min_size              = 3
                                                    eks_node_max_size              = 6
                                                },
                                                {
                                                    name                           = "gpu"
                                                    eks_cluster_version            = "1.32" # "" for CUSTOM eks_node_ami_type
                                                    eks_node_ami_type              = "AL2023_x86_64_NVIDIA" # CUSTOM
                                                    eks_node_instance_type         = "g4dn.2xlarge"
                                                    eks_node_capacity_type         = "ON_DEMAND" # ON_DEMAND or SPOT
                                                    eks_launch_template_id         = "lt-aaaaaaaaaaaa"
                                                    eks_launch_template_version    = 1
                                                    eks_node_min_size              = 2
                                                    eks_node_max_size              = 2
                                                }
                                            ]
global_accelerator_listener_arn          = ""
global_accelerator_traffic_percentage    = 100
alb_arn                                  = ""