data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  aws_region = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id
}

# key policy to allow working with kms keys
data "aws_iam_policy_document" "key_policy" {

  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }

  statement {
    sid = "Allow administration of the key"
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:role/SysAdmin"]
    }
  }

  statement {
    sid = "Allow access through EBS for all principals in the account that are authorized to use EBS"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe",
      "kms:CreateGrant",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = ["*"]
    #best practice: https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-services.html
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["ec2.${local.aws_region}.amazonaws.com"]
    }
  }
}
