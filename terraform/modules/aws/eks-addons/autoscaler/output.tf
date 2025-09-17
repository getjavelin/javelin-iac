output "auto_scaler_iam_policy" {
  description = "IAM Policy for cluster autoscaler service"
  value       = aws_iam_policy.kubernetes_cluster_autoscaler.name
}

output "auto_scaler_iam_role" {
  description = "IAM Role for cluster autoscaler service"
  value       = aws_iam_role.kubernetes_cluster_autoscaler.name
}

output "name" {
  description = "Helm Chart Name"
  value       = helm_release.cluster_autoscaler.name
}

output "namespace" {
  description = "Helm Chart Namespace"
  value       = helm_release.cluster_autoscaler.namespace
}

output "repository" {
  description = "Helm Chart Repository"
  value       = helm_release.cluster_autoscaler.repository
}

output "chart" {
  description = "Helm chart Name"
  value       = helm_release.cluster_autoscaler.chart
}

output "version" {
  description = "Helm Chart Version"
  value       = helm_release.cluster_autoscaler.version
}

output "status" {
  description = "Helm Chart Deployment Status"
  value       = helm_release.cluster_autoscaler.status
}