output "name" {
  description = "Helm Chart Name"
  value       = helm_release.prometheus.name
}

output "namespace" {
  description = "Helm Chart Namespace"
  value       = helm_release.prometheus.namespace
}

output "repository" {
  description = "Helm Chart Repository"
  value       = helm_release.prometheus.repository
}

output "chart" {
  description = "Helm chart Name"
  value       = helm_release.prometheus.chart
}

output "version" {
  description = "Helm Chart Version"
  value       = helm_release.prometheus.version
}

output "status" {
  description = "Helm Chart Deployment Status"
  value       = helm_release.prometheus.status
}

output "prometheus_url" {
  description = "Prometheus URL"
  value       = "http://${helm_release.prometheus.name}-server.${helm_release.prometheus.namespace}.svc.cluster.local"
}