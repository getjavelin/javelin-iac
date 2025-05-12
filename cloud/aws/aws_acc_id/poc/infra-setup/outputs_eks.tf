# ################################################## EKS
output "eks_workernode_template_id" {
  description = "EKS workernode template id"
  value       = var.enable_eks ? module.eks[0].eks_workernode_template_id : null
}

output "eks_kms_key_arn" {
  description = "EKS KMS Key ARN"
  value       = var.enable_eks ? module.eks[0].eks_kms_key_arn : null
}

output "k8s_cluster_name" {
  description = "K8s cluste name"
  value       = var.enable_eks ? module.eks[0].k8s_cluster_name : null
}

output "k8s_cluster_arn" {
  description = "K8s cluste ARN"
  value       = var.enable_eks ? module.eks[0].k8s_cluster_arn : null
}

output "eks_cluster_id" {
  description = "EKS cluster id"
  value       = var.enable_eks ? module.eks[0].eks_cluster_id : null
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoints"
  value       = var.enable_eks ? module.eks[0].eks_cluster_endpoint : null
}

output "eks_cluster_oidc_provider" {
  description = "EKS cluster oidc provider"
  value       = var.enable_eks ? module.eks[0].eks_cluster_oidc_provider : null
}

output "eks_cluster_oidc_provider_arn" {
  description = "EKS cluster oidc provider arn"
  value       = var.enable_eks ? module.eks[0].eks_cluster_oidc_provider_arn : null
}

output "eks_managed_demand_node_group" {
  description = "EKS managed ondemand node groups"
  value       = var.enable_eks ? module.eks[0].eks_managed_demand_node_group : null
}

output "eks_managed_spot_node_group" {
  description = "EKS managed spot node groups"
  value       = var.enable_eks ? module.eks[0].eks_managed_spot_node_group : null
}

output "eks_primary_security_group_id" {
  description = "EKS cluster security group id"
  value       = var.enable_eks ? module.eks[0].eks_primary_security_group_id : null
}

output "eks_node_security_group_id" {
  description = "EKS node security group id"
  value       = var.enable_eks ? module.eks[0].eks_node_security_group_id : null
}

output "eks_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_eks ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> eks" : null
}