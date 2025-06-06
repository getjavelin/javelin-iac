########## Locals ##########
locals {
  iam_prefix                    = join("-", ([var.project_name, var.project_env]))
}

# ########## IAM_Bucket_Policy ##########
# data "aws_iam_policy_document" "bucket_access" {
#   statement {
#     actions                     = [
#                                     "s3:*"
#                                   ]
#     resources                   = [
#                                       "${var.svc_s3_bucket_arn}/*",
#                                       "${var.svc_s3_bucket_arn}"
#                                   ]
#     effect                      = "Allow"
#   }
# }

# resource "aws_iam_policy" "bucket_access" {
#   name                          = "${local.iam_prefix}-s3-access-policy"
#   path                          = "/"
#   description                   = "Policy for acessing the app store s3 bucket"
#   policy                        = data.aws_iam_policy_document.bucket_access.json
# }

########## IAM_KMS_Policy ##########
data "aws_iam_policy_document" "kms_access" {
  statement {
    effect                      = "Allow"
    resources                   = [ "*" ]
    actions                     = [
                                    "kms:Encrypt",
                                    "kms:Decrypt",
                                    "kms:GenerateDataKey*",
                                    "kms:ReEncrypt*",
                                    "kms:DescribeKey"
                                  ]
  }
}

resource "aws_iam_policy" "kms_access" {
  name                          = "${local.iam_prefix}-kms-access-policy"
  path                          = "/"
  description                   = "Policy for acessing the kms"
  policy                        = data.aws_iam_policy_document.kms_access.json
}

########## IAM_Policy ##########
resource "aws_iam_role" "svc_role" {
  name                          = "${local.iam_prefix}-app-role"

  assume_role_policy            = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${var.eks_cluster_oidc_provider_arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "${var.eks_cluster_oidc_provider}:sub": "system:serviceaccount:*",
                    "${var.eks_cluster_oidc_provider}:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
EOF
}

########## Locals ##########
locals {
  svc_iam_policy_list           = concat(var.svc_iam_policy_list,
                                        [
                                          aws_iam_policy.kms_access.arn
                                        ])
}

resource "aws_iam_role_policy_attachment" "iam_policies" {
  count                         = length(local.svc_iam_policy_list)

  role                          = aws_iam_role.svc_role.name
  policy_arn                    = "${local.svc_iam_policy_list[count.index]}"
}