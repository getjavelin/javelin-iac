output "eks_managed_nodegroup_arn" {
  description = "EKS managed nodegroup arn"
  value       = tolist([for arns in module.eks_managed_node_group : arns.node_group_arn])
}