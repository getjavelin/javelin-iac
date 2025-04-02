output "name" {
  description = "Helm Chart Name"
  value       = helm_release.fluent_bit_daemonset.name
}

output "namespace" {
  description = "Helm Chart Namespace"
  value       = helm_release.fluent_bit_daemonset.namespace
}

output "repository" {
  description = "Helm Chart Repository"
  value       = helm_release.fluent_bit_daemonset.repository
}

output "chart" {
  description = "Helm chart Name"
  value       = helm_release.fluent_bit_daemonset.chart
}

output "version" {
  description = "Helm Chart Version"
  value       = helm_release.fluent_bit_daemonset.version
}

output "status" {
  description = "Helm Chart Deployment Status"
  value       = helm_release.fluent_bit_daemonset.status
}