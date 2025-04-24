output "svc_kms_key_arn" {
  description = "KMS Key ARN"
  value       = aws_kms_key.svc_kms.arn
}