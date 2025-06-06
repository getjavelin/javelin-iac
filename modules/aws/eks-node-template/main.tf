########## Locals ##########
locals {
  launch_prefix                 = join("-", [ var.project_name, var.project_env ])
  user_data_tpl                 = "../../../../../../config/aws/common/template/eks_node.tpl"
  tags                          = merge(var.common_tags,
                                      {
                                        EKSCluster = "${local.launch_prefix}-eks"
                                      })
}

########## KMS ##########
resource "aws_kms_key" "eks_node_kms" {
  description                   = "KMS key for encrypt/decrypt operations"
  deletion_window_in_days       = 10
  enable_key_rotation           = true
}

resource "aws_kms_alias" "eks_node_kms" {
  name                          = "alias/${local.launch_prefix}-eks-node"
  target_key_id                 = aws_kms_key.eks_node_kms.key_id
}

data "aws_iam_policy_document" "eks_node_kms" {
  statement {
    effect                      = "Allow"
    resources                   = [ aws_kms_key.eks_node_kms.arn ]
    actions                     = [ "kms:*" ]

    principals {
      type                      = "AWS"
      identifiers               = [ "arn:aws:iam::${var.aws_account_id}:root" ]
    }
  }

  statement {
    effect                      = "Allow"
    resources                   = [ aws_kms_key.eks_node_kms.arn ]
    actions                     = [
                                    "kms:Encrypt",
                                    "kms:Decrypt",
                                    "kms:GenerateDataKey*",
                                    "kms:ReEncrypt*",
                                    "kms:DescribeKey"
                                  ]

    principals {
      type                      = "AWS"
      identifiers               = [ "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling" ]
    }

    condition {
      test                      = "StringEquals"
      variable                  = "kms:CallerAccount"
      values                    = [ "${var.aws_account_id}" ] 
    }
  }

  statement {
    effect                      = "Allow"
    resources                   = [ aws_kms_key.eks_node_kms.arn ]
    actions                     = [
                                    "kms:CreateGrant"
                                  ]

    principals {
      type                      = "AWS"
      identifiers               = [ "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling" ]
    }

    condition {
      test                      = "StringEquals"
      variable                  = "kms:CallerAccount"
      values                    = [ "${var.aws_account_id}" ] 
    }

    condition {
      test                      = "Bool"
      variable                  = "kms:GrantIsForAWSResource"
      values                    = [ true ] 
    }
  }

  statement {
    effect                      = "Allow"
    resources                   = [ aws_kms_key.eks_node_kms.arn ]
    actions                     = [
                                    "kms:Encrypt",
                                    "kms:Decrypt",
                                    "kms:ReEncrypt*",
                                    "kms:GenerateDataKey*",
                                    "kms:CreateGrant",
                                    "kms:DescribeKey"
                                  ]

    principals {
      type                      = "AWS"
      identifiers               = [ "*" ]
    }

    condition {
      test                      = "StringEquals"
      variable                  = "kms:CallerAccount"
      values                    = [ "${var.aws_account_id}" ] 
    }

    condition {
      test                      = "StringEquals"
      variable                  = "kms:ViaService"
      values                    = [ "ec2.${var.region}.amazonaws.com" ] 
    }
  }
}

resource "aws_kms_key_policy" "eks_node_kms" {
  key_id                        = aws_kms_key.eks_node_kms.key_id
  policy                        = data.aws_iam_policy_document.eks_node_kms.json
}

########## Launch_Template ##########
resource "aws_launch_template" "eks_node" {
  for_each                      = { for template in var.custom_template_properties : template.name => template }

  name_prefix                   = "${local.launch_prefix}-${each.value.name}-"
  update_default_version        = true
  image_id                      = each.value.image_id

  block_device_mappings {
    device_name                 = each.value.block_device_name

    ebs {
      volume_size               = each.value.block_device_size
      volume_type               = "gp3"
      delete_on_termination     = true
      encrypted                 = true
      kms_key_id                = aws_kms_key.eks_node_kms.arn
    }
  }

  monitoring {
    enabled                     = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 5
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [ var.eks_nodegroup_sg_id ]
  }

  user_data                     = base64encode(templatefile("${local.user_data_tpl}", {
                                      eks_cluster_endpoint           = var.eks_cluster_endpoint
                                      eks_cluster_ca_data            = var.eks_cluster_ca_data
                                      eks_cluster_service_cidr       = var.eks_cluster_service_cidr
                                      k8s_cluster_name               = var.k8s_cluster_name
                                  }))

  tag_specifications {
    resource_type               = "instance"
    tags                        = merge(local.tags,
                                  {
                                    Name = "${local.launch_prefix}-eks-${each.value.name}"
                                  })
  }

  tag_specifications {
    resource_type               = "volume"
    tags                        = merge(local.tags,
                                  {
                                    Name = "${local.launch_prefix}-eks-${each.value.name}"
                                  })
  }

  tag_specifications {
    resource_type               = "network-interface"
    tags                        = merge(local.tags,
                                  {
                                    Name = "${local.launch_prefix}-eks-${each.value.name}"
                                  })
  }

  lifecycle {
    create_before_destroy       = true
  }
}