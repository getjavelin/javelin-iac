output "global_accelerator_endpoint_group_arn" {
  description = "Global Accelerator Endpoint Group arn"
  value       = aws_globalaccelerator_endpoint_group.global_accelerator.arn
}