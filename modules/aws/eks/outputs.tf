output "eks_kms_key_arn" {
  description = "EKS KMS Key ARN"
  value       = aws_kms_key.eks_kms.arn
}

output "k8s_cluster_name" {
  description = "K8s cluste name"
  value       = module.eks_cluster.cluster_name
}

output "k8s_cluster_arn" {
  description = "K8s cluste ARN"
  value       = module.eks_cluster.cluster_arn
}

output "eks_cluster_id" {
  description = "EKS cluster id"
  value       = module.eks_cluster.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoints"
  value       = module.eks_cluster.cluster_endpoint
}

output "eks_cluster_token" {
  description = "EKS cluster token"
  value       = data.aws_eks_cluster_auth.eks_cluster.token
}

output "eks_cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  value       = module.eks_cluster.cluster_certificate_authority_data
}

output "eks_cluster_oidc_provider" {
  description = "EKS cluster oidc provider"
  value       = module.eks_cluster.oidc_provider
}

output "eks_cluster_oidc_provider_arn" {
  description = "EKS cluster oidc provider arn"
  value       = module.eks_cluster.oidc_provider_arn
}

output "eks_primary_security_group_id" {
  description = "EKS cluster security group id"
  value       =  module.eks_cluster.cluster_primary_security_group_id
}

output "eks_node_security_group_id" {
  description = "EKS node security group id"
  value       = module.eks_cluster.node_security_group_id
}

output "eks_cluster_service_cidr" {
  description = "EKS cluster service cidr"
  value       = module.eks_cluster.cluster_service_cidr
}

output "eks_cluster_primary_sg_id" {
  description = "EKS cluster primary sg id"
  value       = module.eks_cluster.cluster_primary_security_group_id
}