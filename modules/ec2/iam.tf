data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  aws_region     = data.aws_region.current.name
  aws_account_id = data.aws_caller_identity.current.account_id

  bootstrap_delivery_aws_profile_name = "bootstrap-s3-delivery"
}
# This policy allows the EC2 instances to assume the role by 
# using the AWS Security Token Service (STS) AssumeRole API action.
data "aws_iam_policy_document" "trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Role that gets the trust policy asigned.
resource "aws_iam_role" "default" {
  name               = "${var.component_name}-ec2"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json

}

# The instance profile to pass the role default to an EC2 instance.
resource "aws_iam_instance_profile" "default" {
  name_prefix = var.component_name
  role        = aws_iam_role.default.name
}
