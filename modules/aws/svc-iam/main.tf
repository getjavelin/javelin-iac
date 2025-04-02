########## Locals ##########
locals {
  iam_prefix      = join("-", ([var.project_name, var.project_env]))
}

# ########## IAM_Bucket_Policy ##########
# data "aws_iam_policy_document" "bucket_access" {
#   statement {
#     actions = [
#       "s3:*"
#     ]
#     resources = [
#         "${var.svc_s3_bucket_arn}/*",
#         "${var.svc_s3_bucket_arn}"
#     ]
#     effect = "Allow"
#   }
# }

# resource "aws_iam_policy" "bucket_access" {
#   name        = "${local.iam_prefix}-s3-access-policy"
#   path        = "/"
#   description = "Policy for acessing the app store s3 bucket"
#   policy = data.aws_iam_policy_document.bucket_access.json
# }

########## IAM_Bedrock_Policy ##########
data "aws_iam_policy_document" "bedrock_access" {
  statement {
    actions = [
      "bedrock:InvokeModel",
      "bedrock:InvokeModelWithResponseStream",
      "bedrock:GetFoundationModel",
      "bedrock:ListFoundationModels",
      "bedrock:GetModelInvocationLoggingConfiguration",
      "bedrock:GetProvisionedModelThroughput",
      "bedrock:ListProvisionedModelThroughputs",
      "bedrock:GetModelCustomizationJob",
      "bedrock:ListModelCustomizationJobs",
      "bedrock:ListCustomModels",
      "bedrock:GetCustomModel",
      "bedrock:ListTagsForResource",
      "bedrock:GetFoundationModelAvailability"
    ]
    resources = [ "*" ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "bedrock_access" {
  name        = "${local.iam_prefix}-bedrock-access-policy"
  path        = "/"
  description = "Policy for acessing the bedrock"
  policy = data.aws_iam_policy_document.bedrock_access.json
}

resource "aws_iam_role" "svc_role" {
  name = "${local.iam_prefix}-app-role"

  assume_role_policy = <<EOF
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

# resource "aws_iam_role_policy_attachment" "secret_access" {
#   role       = aws_iam_role.svc_role.name
#   policy_arn = aws_iam_policy.bucket_access.arn
# }

resource "aws_iam_role_policy_attachment" "bedrock_access" {
  role       = aws_iam_role.svc_role.name
  policy_arn = aws_iam_policy.bedrock_access.arn
}

resource "aws_iam_role_policy_attachment" "iam_policies" {
  count      = length(var.svc_iam_policy_list)

  role       = aws_iam_role.svc_role.name
  policy_arn = "${var.svc_iam_policy_list[count.index]}"
}


resource "aws_iam_user" "svc_user" {
  name                = "${local.iam_prefix}-app-user"
}

resource "aws_iam_user_policy_attachment" "bedrock_access" {
  user                = aws_iam_user.svc_user.name
  policy_arn          = aws_iam_policy.bedrock_access.arn
}

resource "aws_iam_user_policy_attachment" "iam_policies" {
  count               = length(var.svc_iam_policy_list)

  user                = aws_iam_user.svc_user.name
  policy_arn          = "${var.svc_iam_policy_list[count.index]}"
}

resource "aws_iam_access_key" "svc_user_access_key" {
  depends_on          = [ aws_iam_user.svc_user ]
  user                = aws_iam_user.svc_user.name
}