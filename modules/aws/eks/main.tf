########## Locals ##########
locals {
  cluster_name                  = join("-", [var.project_name, var.project_env, "eks"])
  tags                          = merge(var.common_tags,
                                      {
                                        EKSCluster = local.cluster_name
                                      })
}

########## Launch_Template ##########
resource "aws_launch_template" "eks_cluster" {
  name_prefix                   = "${local.cluster_name}-launch-template"
  update_default_version        = true

  block_device_mappings {
    device_name                 = "/dev/xvda"

    ebs {
      volume_size               = var.eks_node_disk_size
      volume_type               = "gp3"
      delete_on_termination     = true
    }
  }

  monitoring {
    enabled                     = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [ var.eks_nodegroup_sg_id ]
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.tags,
                        {
                          Name = local.cluster_name
                        })
  }

  tag_specifications {
    resource_type = "volume"
    tags          = merge(local.tags,
                        {
                          Name = local.cluster_name
                        })
  }

  tag_specifications {
    resource_type = "network-interface"
    tags          = merge(local.tags,
                        {
                          Name = local.cluster_name
                        })
  }

  lifecycle {
    create_before_destroy       = true
  }
}

########## EKS_Cluster ##########
module "eks_cluster" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "20.33.1"

  cluster_name                             = local.cluster_name
  cluster_version                          = var.eks_cluster_version
  vpc_id                                   = var.vpc_id
  subnet_ids                               = var.private_subnet_ids
  cluster_endpoint_private_access          = true
  cluster_endpoint_public_access           = true
  cluster_endpoint_public_access_cidrs     = [ var.devops_public_cidr ]
  create_cloudwatch_log_group              = true
  enable_irsa                              = true
  authentication_mode                      = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true
  create_cluster_security_group            = false
  create_node_security_group               = false
  cluster_security_group_id                = var.eks_cluster_sg_id
  node_security_group_id                   = var.eks_nodegroup_sg_id

  cloudwatch_log_group_retention_in_days = var.eks_cloudwatch_retention
  # cluster_enabled_log_types = []
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  cluster_addons_timeouts = {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

  tags = merge(var.tags.eks, local.tags)
}

########## EKS_NodeGroup_ON_Demand ##########
module "eks_managed_demand_node_group" {
  count                             = var.eks_demand_node_group_enable == true ? 1 : 0
  source                            = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version                           = "20.33.1"

  create_launch_template            = false
  use_custom_launch_template        = true
  launch_template_id                = aws_launch_template.eks_cluster.id
  launch_template_version           = aws_launch_template.eks_cluster.latest_version

  name                              = "${local.cluster_name}-demand"
  cluster_name                      = local.cluster_name
  cluster_version                   = var.eks_cluster_version
  subnet_ids                        = var.private_subnet_ids
  min_size                          = var.eks_demand_node_min_size
  desired_size                      = var.eks_demand_node_min_size
  max_size                          = var.eks_demand_node_max_size
  instance_types                    = [var.eks_demand_node_instance_type]
  capacity_type                     = "ON_DEMAND"
  ami_type                          = var.eks_node_ami_type
  cluster_service_cidr              = module.eks_cluster.cluster_service_cidr
  cluster_primary_security_group_id = module.eks_cluster.cluster_primary_security_group_id
  vpc_security_group_ids            = [
                                        var.eks_nodegroup_sg_id
                                      ]
  update_config                     = {
                                        max_unavailable_percentage = 33
                                      }
  iam_role_additional_policies      = {
                                        cloudwatch      = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
                                        cloudWatchLogs  = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
                                        ebscsi          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
                                      }
  tags                              = local.tags
  labels                            = {
                                        "kube/nodegroup"        = "generic"
                                        "kube/nodetype"         = "demand"
                                        "kube/project_env"      = "${var.project_env}"
                                        "kube/project_name"     = "${var.project_name}"
                                      }
}

########## EKS_NodeGroup_Spot ##########
module "eks_managed_spot_node_group" {
  count                             = var.eks_spot_node_group_enable == true ? 1 : 0

  source                            = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version                           = "20.33.1"

  create_launch_template            = false
  use_custom_launch_template        = true
  launch_template_id                = aws_launch_template.eks_cluster.id
  launch_template_version           = aws_launch_template.eks_cluster.latest_version

  name                              = "${local.cluster_name}-spot"
  cluster_name                      = local.cluster_name
  cluster_version                   = var.eks_cluster_version
  subnet_ids                        = var.private_subnet_ids
  min_size                          = var.eks_spot_node_min_size
  desired_size                      = var.eks_spot_node_min_size
  max_size                          = var.eks_spot_node_max_size
  instance_types                    = [var.eks_spot_node_instance_type]
  capacity_type                     = "SPOT"
  ami_type                          = var.eks_node_ami_type
  cluster_service_cidr              = module.eks_cluster.cluster_service_cidr
  cluster_primary_security_group_id = module.eks_cluster.cluster_primary_security_group_id
  vpc_security_group_ids            = [
                                        var.eks_nodegroup_sg_id
                                      ]
  update_config                     = {
                                        max_unavailable_percentage = 33
                                      }
  iam_role_additional_policies      = {
                                        cloudwatch      = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
                                        cloudWatchLogs  = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
                                        ebscsi          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
                                      }
  tags                              = local.tags
  labels                            = {
                                        "kube/nodegroup"        = "general"
                                        "kube/nodetype"         = "spot"
                                        "kube/project_env"      = "${var.project_env}"
                                        "kube/project_name"     = "${var.project_name}"
                                      }
}

########## EKS_Addon ##########
data "aws_eks_addon_version" "default_version" {
  for_each                    = { for addon in var.addons : addon.name => addon }
  addon_name                  = each.value.name
  kubernetes_version          = module.eks_cluster.cluster_version
}

resource "aws_eks_addon" "eks_cluster_addons" {
  depends_on                  = [ data.aws_eks_addon_version.default_version ]
  for_each                    = { for addon in var.addons : addon.name => addon }
  cluster_name                = module.eks_cluster.cluster_name
  addon_name                  = each.value.name
  # addon_version               = each.value.version
  addon_version               = data.aws_eks_addon_version.default_version[each.key].version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags                        = merge(var.tags.eks_addon, local.tags)
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks_cluster.cluster_name
}