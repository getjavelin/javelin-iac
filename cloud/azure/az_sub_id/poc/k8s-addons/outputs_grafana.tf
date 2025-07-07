output "grafana_name" {
  description = "Helm Chart Name"
  value       = var.enable_grafana ? module.grafana[0].name : null
}

output "grafana_namespace" {
  description = "Helm Chart Namespace"
  value       = var.enable_grafana ? module.grafana[0].namespace : null
}

output "grafana_repository" {
  description = "Helm Chart Repository"
  value       = var.enable_grafana ? module.grafana[0].repository : null
}

output "grafana_chart" {
  description = "Helm chart Name"
  value       = var.enable_grafana ? module.grafana[0].chart : null
}

output "grafana_version" {
  description = "Helm Chart Version"
  value       = var.enable_grafana ? module.grafana[0].version : null
}

output "grafana_status" {
  description = "Helm Chart Deployment Status"
  value       = var.enable_grafana ? module.grafana[0].status : null
}

output "grafana_username" {
  description = "Grafana Username"
  value       = var.enable_grafana ? module.grafana[0].grafana_username : null
}

output "grafana_password" {
  description = "Grafana Password"
  value       = var.enable_grafana ? module.grafana[0].grafana_password : null
  sensitive   = true
}

output "grafana_url" {
  description = "Grafana URL"
  value       = var.enable_grafana ? module.grafana[0].grafana_url : null
}

output "grafana_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_grafana ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> grafana" : null
}