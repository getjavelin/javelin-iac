# ################################################## svc_iam
output "javelin_svc_iam_role_name" {
  description = "Javelin IAM role name for services"
  value       = var.enable_svc_iam ? module.svc_iam[0].iam_role_name : null
}

output "javelin_svc_iam_role_arn" {
  description = "Javelin IAM role arn for services"
  value       = var.enable_svc_iam ? module.svc_iam[0].iam_role_arn : null
}

output "javelin_svc_iam_user_name" {
  description = "Javelin IAM User name for services"
  value       = var.enable_svc_iam ? module.svc_iam[0].iam_user_name : null
}

output "javelin_svc_iam_user_arn" {
  description = "Javelin IAM User arn for services"
  value       = var.enable_svc_iam ? module.svc_iam[0].iam_user_arn : null
}

output "javelin_svc_user_access_key_id" {
  description = "Javelin IAM User Access Key ID"
  value       = var.enable_svc_iam ? module.svc_iam[0].svc_user_access_key_id : null
}

output "javelin_svc_user_secret_access_key" {
  description = "Javelin IAM User Secret Access Key"
  value       = var.enable_svc_iam ? module.svc_iam[0].svc_user_secret_access_key : null
  sensitive   = true
}

# output "javelin_svc_iam_bucket_access_policy_arn" {
#   description = "Javelin IAM user's bucket access iam policy"
#   value       = var.enable_svc_iam ? module.svc_iam[0].iam_bucket_access_policy_arn : null
# }

output "javelin_svc_iam_bedrock_access_policy_arn" {
  description = "Javelin IAM user's bedrock access iam policy"
  value       = var.enable_svc_iam ? module.svc_iam[0].iam_bedrock_access_policy_arn : null
}

output "javelin_svc_iam_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_svc_iam ?  ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> javelin_svc_iam" : null
}