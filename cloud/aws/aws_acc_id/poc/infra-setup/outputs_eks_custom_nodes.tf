output "eks_custom_nodegroup_arn" {
  description = "EKS custom nodegroup arn"
  value       = var.enable_eks_custom_nodes ? module.eks_custom_nodes[0].eks_custom_nodegroup_arn : null
}

output "eks_custom_nodegroup_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_eks_custom_nodes ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> eks_custom_nodegroup" : null
}