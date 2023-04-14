data "aws_ssm_parameter" "mandatory_tags" {
  name = "/${var.project_prefix}/component/config/output/mandatorytags/json"
}

data "aws_ssm_parameter" "account_short_name" {
  name = "/${var.project_prefix}/component/config/output/account-short-name"
}

data "aws_ssm_parameter" "account_id" {
  name = "/${var.project_prefix}/component/config/output/account-id"
}

locals {
  mandatory_tags = merge(
    tomap({ "project:meta:component" = local.component.name }),
    nonsensitive(jsondecode(data.aws_ssm_parameter.mandatory_tags.value))
  )
  account_short_name = nonsensitive(data.aws_ssm_parameter.account_short_name.value)
  account_id    = nonsensitive(data.aws_ssm_parameter.account_id.value)
}
