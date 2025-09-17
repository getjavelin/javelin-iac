########## Locals ##########
locals {
  sg_prefix  = join("-", ([ var.project_name, var.project_env ]))
}

########## Cluster_Security_Group ##########
resource "aws_security_group" "eks_cluster_sg" {
  vpc_id      = var.vpc_id
  name        = "${local.sg_prefix}-eks-cluster-sg"
  description = "Security Group for EKS Cluster Traffic"

  tags = {
    "Name" = "${local.sg_prefix}-eks-cluster-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_cluster_internal_egress_rule" {
  ip_protocol       = "-1"
  cidr_ipv4         = "${var.vpc_cidr}"
  security_group_id = aws_security_group.eks_cluster_sg.id
  description       = "terraform - vpc internal egress"
  tags = {
    Name = "terraform - vpc internal egress"
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_cluster_default_egress_rule" {
  from_port         = var.sg_egress_from_port
  to_port           = var.sg_egress_to_port
  ip_protocol       = var.sg_egress_protocol
  cidr_ipv4         = "${var.sg_egress_cidr}"
  security_group_id = aws_security_group.eks_cluster_sg.id
  description       = "terraform - default egress"
  tags = {
    Name = "terraform - default egress"
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_cluster_default_ipv6_egress_rule" {
  count             = var.sg_ipv6_egress_enable == true ? 1 : 0

  from_port         = var.sg_egress_from_port
  to_port           = var.sg_egress_to_port
  ip_protocol       = var.sg_egress_protocol
  cidr_ipv6         = "${var.sg_ipv6_egress_cidr}"
  security_group_id = aws_security_group.eks_cluster_sg.id
  description       = "terraform - default ipv6 egress"
  tags = {
    Name = "terraform - default ipv6 egress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_cluster_additional_ingress_rule" {
  for_each                     = toset(var.additional_whitelist_cidr)

  from_port                    = var.https_port
  to_port                      = var.https_port
  ip_protocol                  = "tcp"
  cidr_ipv4                    = each.value
  security_group_id            = aws_security_group.eks_cluster_sg.id
  description                  = "terraform - eks access from ${each.value}"
  tags = {
    Name = "terraform - eks access from ${each.value}"
  }
}

# ########## Cluster_Node_Security_Group ##########
# resource "aws_security_group" "eks_cluster_node_sg" {
#   vpc_id      = var.vpc_id
#   name        = "${local.sg_prefix}-eks-cluster-node-sg"
#   description = "Security Group for EKS Cluster - Node Traffic"

#   tags = {
#     "Name" = "${local.sg_prefix}-eks-cluster-node-sg"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_vpc_security_group_egress_rule" "eks_cluster_node_internal_egress_rule" {
#   ip_protocol       = "-1"
#   cidr_ipv4         = "${var.vpc_cidr}"
#   security_group_id = aws_security_group.eks_cluster_node_sg.id
#   description       = "terraform - vpc internal egress"
#   tags = {
#     Name = "terraform - vpc internal egress"
#   }
# }

# resource "aws_vpc_security_group_egress_rule" "eks_cluster_node_default_egress_rule" {
#   from_port         = var.sg_egress_from_port
#   to_port           = var.sg_egress_to_port
#   ip_protocol       = var.sg_egress_protocol
#   cidr_ipv4         = "${var.sg_egress_cidr}"
#   security_group_id = aws_security_group.eks_cluster_node_sg.id
#   description       = "terraform - eks cluster - node default egress"
#   tags = {
#     Name = "terraform - eks cluster - node default egress"
#   }
# }

# resource "aws_vpc_security_group_egress_rule" "eks_cluster_node_default_ipv6_egress_rule" {
#   count             = var.sg_ipv6_egress_enable == true ? 1 : 0

#   from_port         = var.sg_egress_from_port
#   to_port           = var.sg_egress_to_port
#   ip_protocol       = var.sg_egress_protocol
#   cidr_ipv6         = "${var.sg_ipv6_egress_cidr}"
#   security_group_id = aws_security_group.eks_cluster_node_sg.id
#   description       = "terraform - eks cluster - node default ipv6 egress"
#   tags = {
#     Name = "terraform - eks cluster - node default ipv6 egress"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "eks_cluster_node_ingress_rule" {
#   ip_protocol                  = "-1"
#   referenced_security_group_id = aws_security_group.eks_cluster_node_sg.id
#   security_group_id            = aws_security_group.eks_cluster_node_sg.id
#   description                  = "terraform - eks cluster - node traffic"
#   tags = {
#     Name = "terraform - eks cluster - node traffic"
#   }
# }

########## Node_Security_Group ##########
resource "aws_security_group" "eks_nodegroup_sg" {
  vpc_id      = var.vpc_id
  name        = "${local.sg_prefix}-eks-nodegroup-sg"
  description = "Security Group for EKS NodeGroup Traffic"

  tags = {
    "Name" = "${local.sg_prefix}-eks-nodegroup-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_nodes_internal_egress_rule" {
  ip_protocol       = "-1"
  cidr_ipv4         = "${var.vpc_cidr}"
  security_group_id = aws_security_group.eks_nodegroup_sg.id
  description       = "terraform - vpc internal egress"
  tags = {
    Name = "terraform - vpc internal egress"
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_nodes_default_egress_rule" {
  from_port         = var.sg_egress_from_port
  to_port           = var.sg_egress_to_port
  ip_protocol       = var.sg_egress_protocol
  cidr_ipv4         = "${var.sg_egress_cidr}"
  security_group_id = aws_security_group.eks_nodegroup_sg.id
  description       = "terraform - default egress"
  tags = {
    Name = "terraform - default egress"
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_nodes_default_ipv6_egress_rule" {
  count             = var.sg_ipv6_egress_enable == true ? 1 : 0

  from_port         = var.sg_egress_from_port
  to_port           = var.sg_egress_to_port
  ip_protocol       = var.sg_egress_protocol
  cidr_ipv6         = "${var.sg_ipv6_egress_cidr}"
  security_group_id = aws_security_group.eks_nodegroup_sg.id
  description       = "terraform - default ipv6 egress"
  tags = {
    Name = "terraform - default ipv6 egress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_nodes_cluster_ingress_rule" {
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.eks_cluster_sg.id
  security_group_id            = aws_security_group.eks_nodegroup_sg.id
  description                  = "terraform - eks access from eks cluster"
  tags = {
    Name = "terraform - eks access from eks cluster"
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_nodes_nodes_ingress_rule" {
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.eks_nodegroup_sg.id
  security_group_id            = aws_security_group.eks_nodegroup_sg.id
  description                  = "terraform - eks access from eks nodes"
  tags = {
    Name = "terraform - eks access from eks nodes"
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_cluster_nodes_ingress_rule" {
  from_port                    = var.https_port
  to_port                      = var.https_port
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eks_nodegroup_sg.id
  security_group_id            = aws_security_group.eks_cluster_sg.id
  description                  = "terraform - eks nodes access to eks cluster"
  tags = {
    Name = "terraform - eks nodes access to eks cluster"
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_nodes_custom_egress_rule" {
  count             = length(var.custom_egress_port_list)
  
  from_port         = "${var.custom_egress_port_list[count.index]}"
  to_port           = "${var.custom_egress_port_list[count.index]}"
  ip_protocol       = var.sg_egress_protocol
  cidr_ipv4         = "${var.sg_egress_cidr}"
  security_group_id = aws_security_group.eks_nodegroup_sg.id
  description       = "terraform - ${var.custom_egress_port_list[count.index]} egress"
  tags = {
    Name = "terraform - ${var.custom_egress_port_list[count.index]} egress"
  }
}