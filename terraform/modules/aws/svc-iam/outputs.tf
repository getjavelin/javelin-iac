output "iam_role_name" {
  description = "IAM Role name"
  value       = aws_iam_role.svc_role.name
}

output "iam_role_arn" {
  description = "IAM Role arn"
  value       = aws_iam_role.svc_role.arn
}

# output "iam_bucket_access_policy_arn" {
#   description = "IAM Bucket Access Policy arn"
#   value       = aws_iam_policy.bucket_access.arn
# }