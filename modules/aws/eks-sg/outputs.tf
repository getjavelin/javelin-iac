output "eks_cluster_sg_id" {
  description = "EKS Cluster Security Group ID"
  value       = aws_security_group.eks_cluster_sg.id
}

output "eks_cluster_sg_name" {
  description = "EKS Cluster Security Group Name"
  value       = aws_security_group.eks_cluster_sg.name
}

output "eks_cluster_sg_arn" {
  description = "EKS Cluster Security Group arn"
  value       = aws_security_group.eks_cluster_sg.arn
}

output "eks_nodegroup_sg_id" {
  description = "EKS NodeGroup Security Group ID"
  value       = aws_security_group.eks_nodegroup_sg.id
}

output "eks_nodegroup_sg_name" {
  description = "EKS NodeGroup Security Group Name"
  value       = aws_security_group.eks_nodegroup_sg.name
}

output "eks_nodegroup_sg_arn" {
  description = "EKS NodeGroup Security Group arn"
  value       = aws_security_group.eks_nodegroup_sg.arn
}