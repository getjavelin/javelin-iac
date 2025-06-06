output "eks_node_kms_key_arn" {
  description = "EKS Node KMS Key ARN"
  value       = aws_kms_key.eks_node_kms.arn
}

output "eks_node_launch_template_id" {
  description = "EKS node launch template id"
  value       = {
                  for k, template in aws_launch_template.eks_node :
                  k => template.id
                }
}

output "eks_node_launch_template_version" {
  description = "EKS node launch template version"
  value       = {
                  for k, template in aws_launch_template.eks_node :
                  k => template.latest_version
                }
}