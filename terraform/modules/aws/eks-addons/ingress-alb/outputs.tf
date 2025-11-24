output "alb_ingress_iam_role_arn" {
  description = "IAM Role for ALB Ingress Controller"
  value       = module.ingress_alb_role.arn
}

output "name" {
  description = "Helm Chart Name"
  value       = helm_release.ingress_alb.name
}

output "namespace" {
  description = "Helm Chart Namespace"
  value       = helm_release.ingress_alb.namespace
}

output "repository" {
  description = "Helm Chart Repository"
  value       = helm_release.ingress_alb.repository
}

output "chart" {
  description = "Helm chart Name"
  value       = helm_release.ingress_alb.chart
}

output "version" {
  description = "Helm Chart Version"
  value       = helm_release.ingress_alb.version
}

output "status" {
  description = "Helm Chart Deployment Status"
  value       = helm_release.ingress_alb.status
}