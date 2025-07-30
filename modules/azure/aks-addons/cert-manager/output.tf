output "name" {
  description = "Helm Chart Name"
  value       = helm_release.cert_manager.name
}

output "namespace" {
  description = "Helm Chart Namespace"
  value       = helm_release.cert_manager.namespace
}

output "repository" {
  description = "Helm Chart Repository"
  value       = helm_release.cert_manager.repository
}

output "chart" {
  description = "Helm chart Name"
  value       = helm_release.cert_manager.chart
}

output "version" {
  description = "Helm Chart Version"
  value       = helm_release.cert_manager.version
}

output "status" {
  description = "Helm Chart Deployment Status"
  value       = helm_release.cert_manager.status
}