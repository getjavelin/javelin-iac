# ################################################## svc_iam
output "javelin_svc_iam_role_name" {
  description = "Javelin IAM role name for services"
  value       = var.enable_svc_iam ? module.svc_iam[0].iam_role_name : null
}

output "javelin_svc_iam_role_arn" {
  description = "Javelin IAM role arn for services"
  value       = var.enable_svc_iam ? module.svc_iam[0].iam_role_arn : null
}

# output "javelin_svc_iam_bucket_access_policy_arn" {
#   description = "Javelin IAM user's bucket access iam policy"
#   value       = var.enable_svc_iam ? module.svc_iam[0].iam_bucket_access_policy_arn : null
# }

output "javelin_svc_iam_zzzzzz" {
  description = "Separation in the output"
  value       = var.enable_svc_iam ?  ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> javelin_svc_iam" : null
}