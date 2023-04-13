
# KMS key with the policy document key policy that describes how the KMS key can be used.
resource "aws_kms_key" "default" {
  description             = var.kms_key_description
  deletion_window_in_days = 30
  is_enabled              = true
  enable_key_rotation     = true
  tags                    = var.tags
  policy                  = data.aws_iam_policy_document.key_policy.json
}

resource "aws_kms_alias" "default" {
  name          = var.kms_key_alias
  target_key_id = aws_kms_key.default.key_id
}
