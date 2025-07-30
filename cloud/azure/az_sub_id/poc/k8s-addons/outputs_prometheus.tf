################################################## Helm_Chart_prometheus
output "prometheus_name" {
  description = "Helm Chart Name"
  value       = var.enable_prometheus ? module.prometheus[0].name : null
}

output "prometheus_namespace" {
  description = "Helm Chart Namespace"
  value       = var.enable_prometheus ? module.prometheus[0].namespace : null
}

output "prometheus_repository" {
  description = "Helm Chart Repository"
  value       = var.enable_prometheus ? module.prometheus[0].repository : null
}

output "prometheus_chart" {
  description = "Helm chart Name"
  value       = var.enable_prometheus ? module.prometheus[0].chart : null
}

output "prometheus_version" {
  description = "Helm Chart Version"
  value       = var.enable_prometheus ? module.prometheus[0].version : null
}

output "prometheus_status" {
  description = "Helm Chart Deployment Status"
  value       = var.enable_prometheus ? module.prometheus[0].status : null
}

output "prometheus_url" {
  description = "Prometheus URL"
  value       = var.enable_prometheus ? module.prometheus[0].prometheus_url : null
}

output "prometheus_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_prometheus ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> prometheus" : null
}