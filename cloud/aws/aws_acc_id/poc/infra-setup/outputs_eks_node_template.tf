output "eks_node_template_kms_key_arn" {
  description = "EKS Node KMS Key ARN"
  value       = var.enable_eks ? module.eks_node_template[0].eks_node_kms_key_arn : null
}

output "eks_node_template_id" {
  description = "EKS node launch template id"
  value       = var.enable_eks ? module.eks_node_template[0].eks_node_launch_template_id : null
}

output "eks_node_template_version" {
  description = "EKS node launch template version"
  value       = var.enable_eks ? module.eks_node_template[0].eks_node_launch_template_version : null
}

output "eks_node_template_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_eks ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> eks_node_template" : null
}