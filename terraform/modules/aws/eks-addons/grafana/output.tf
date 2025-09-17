output "name" {
  description = "Helm Chart Name"
  value       = helm_release.grafana.name
}

output "namespace" {
  description = "Helm Chart Namespace"
  value       = helm_release.grafana.namespace
}

output "repository" {
  description = "Helm Chart Repository"
  value       = helm_release.grafana.repository
}

output "chart" {
  description = "Helm chart Name"
  value       = helm_release.grafana.chart
}

output "version" {
  description = "Helm Chart Version"
  value       = helm_release.grafana.version
}

output "status" {
  description = "Helm Chart Deployment Status"
  value       = helm_release.grafana.status
}

output "grafana_secret" {
  description = "Grafana Secret"
  value       = random_password.grafana_secret.result
  sensitive   = true
}

output "grafana_url" {
  description = "Grafana URL"
  value       = "https://${var.grafana_domain}/${var.grafana_subpath}"
}