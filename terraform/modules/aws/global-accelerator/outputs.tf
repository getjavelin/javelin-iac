output "global_accelerator_arn" {
  description = "Global Accelerator arn"
  value       = aws_globalaccelerator_accelerator.global_accelerator.arn
}

output "global_accelerator_dns" {
  description = "Global Accelerator DNS"
  value       = aws_globalaccelerator_accelerator.global_accelerator.dns_name
}

output "global_accelerator_listener_arn" {
  description = "Global Accelerator Listener arn"
  value       = aws_globalaccelerator_listener.global_accelerator.arn
}