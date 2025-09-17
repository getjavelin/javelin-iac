## Terraform Backend Variables
bucket                          = "javelin-tf-poc"
## Enable required services
enable_namespace                = false
enable_docker_secret            = false
enable_storageclass             = false
enable_autoscaler               = false
enable_fluent_bit               = false
enable_ingress_alb_crds         = false
enable_ingress_alb              = false
enable_prometheus               = false
enable_grafana                  = false
enable_metrics_server           = false
## Resource Variables
common_tags                     = {
                                        ManagedBy   = "Terraform"
                                }
region                          = "us-east-1"
project_name                    = "javelin"
project_env                     = "poc"
### WARNING : Don't save this
registry_password               = ""
cloudwatch_log_retention        = 30
service_namespace               = "javelin-poc"
frontend_acm_certificate_arn    = ""
grafana_acm_certificate_arn     = ""
grafana_domain                  = ""