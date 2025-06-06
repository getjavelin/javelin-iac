########## Locals ##########
locals {
  tags                              = merge(var.common_tags,
                                          {
                                            EKSCluster = var.cluster_name
                                          })
}

########## EKS_Custom_NodeGroup ##########
module "eks_managed_custom_node_group" {
  for_each                          = { for nodes in var.custom_nodes_properties : nodes.name => nodes }

  source                            = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version                           = "20.13.1"

  create_launch_template            = false
  use_custom_launch_template        = true
  launch_template_id                = each.value.eks_launch_template_id
  launch_template_version           = each.value.eks_launch_template_version

  name                              = "${each.value.name}-${replace(lower(each.value.eks_node_capacity_type), "_", "-")}"
  cluster_name                      = var.cluster_name
  cluster_version                   = each.value.eks_cluster_version
  subnet_ids                        = var.private_subnet_ids
  min_size                          = each.value.eks_node_min_size
  desired_size                      = each.value.eks_node_min_size
  max_size                          = each.value.eks_node_max_size
  capacity_type                     = each.value.eks_node_capacity_type
  instance_types                    = [ each.value.eks_node_instance_type ]
  ami_type                          = each.value.eks_node_ami_type
  cluster_service_cidr              = var.eks_cluster_service_cidr
  cluster_primary_security_group_id = var.eks_cluster_primary_sg_id
  vpc_security_group_ids            = [ var.eks_nodegroup_sg_id ]
  update_config                     = {
                                        max_unavailable_percentage = 33
                                      }
  iam_role_additional_policies      = {
                                        cloudwatch      = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
                                        cloudWatchLogs  = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
                                        ebscsi          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
                                      }
  tags                              = merge({NodeType = "${each.value.name}"}, local.tags)
  labels                            = {
                                        "kube/nodegroup"        = "${each.value.name}"
                                        "kube/nodetype"         = "${each.value.name}-${replace(lower(each.value.eks_node_capacity_type), "_", "-")}"
                                        "kube/project_env"      = "${var.project_env}"
                                        "kube/project_name"     = "${var.project_name}"
                                      }
}