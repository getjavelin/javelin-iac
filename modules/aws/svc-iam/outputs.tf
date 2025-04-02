output "iam_role_name" {
  description = "IAM Role name"
  value       = aws_iam_role.svc_role.name
}

output "iam_role_arn" {
  description = "IAM Role arn"
  value       = aws_iam_role.svc_role.arn
}

output "iam_user_name" {
  description = "IAM User name"
  value       = aws_iam_user.svc_user.name
}

output "iam_user_arn" {
  description = "IAM User arn"
  value       = aws_iam_user.svc_user.arn
}

output "svc_user_access_key_id" {
  description = "Javelin IAM User Access Key ID"
  value       = aws_iam_access_key.svc_user_access_key.id
}

output "svc_user_secret_access_key" {
  description = "Javelin IAM User Secret Access Key"
  value       = aws_iam_access_key.svc_user_access_key.secret
  sensitive   = true
}

# output "iam_bucket_access_policy_arn" {
#   description = "IAM Bucket Access Policy arn"
#   value       = aws_iam_policy.bucket_access.arn
# }

output "iam_bedrock_access_policy_arn" {
  description = "IAM Bedrock Access Policy arn"
  value       = aws_iam_policy.bedrock_access.arn
}