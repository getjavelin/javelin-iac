output "eks_custom_nodegroup_arn" {
  description = "EKS custom nodegroup arn"
  value       = tolist([for arns in module.eks_managed_custom_node_group : arns.node_group_arn])
}