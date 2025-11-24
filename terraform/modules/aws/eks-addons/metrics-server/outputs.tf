output "name" {
  description = "Helm Chart Name"
  value       = helm_release.metrics_server.name
}

output "namespace" {
  description = "Helm Chart Namespace"
  value       = helm_release.metrics_server.namespace
}

output "repository" {
  description = "Helm Chart Repository"
  value       = helm_release.metrics_server.repository
}

output "chart" {
  description = "Helm chart Name"
  value       = helm_release.metrics_server.chart
}

output "version" {
  description = "Helm Chart Version"
  value       = helm_release.metrics_server.version
}

output "status" {
  description = "Helm Chart Deployment Status"
  value       = helm_release.metrics_server.status
}