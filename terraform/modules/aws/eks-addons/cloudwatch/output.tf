output "cloudwatch_metrics_iam_role" {
  description = "IAM Role for accessing aws cloudwatch metrics"
  value       = aws_iam_role.aws_cloudwatch.name
}

output "name" {
  description = "Helm Chart Name"
  value       = helm_release.aws_cloudwatch_metrics.name
}

output "namespace" {
  description = "Helm Chart Namespace"
  value       = helm_release.aws_cloudwatch_metrics.namespace
}

output "repository" {
  description = "Helm Chart Repository"
  value       = helm_release.aws_cloudwatch_metrics.repository
}

output "chart" {
  description = "Helm chart Name"
  value       = helm_release.aws_cloudwatch_metrics.chart
}

output "version" {
  description = "Helm Chart Version"
  value       = helm_release.aws_cloudwatch_metrics.version
}

output "status" {
  description = "Helm Chart Deployment Status"
  value       = helm_release.aws_cloudwatch_metrics.status
}