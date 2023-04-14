data "aws_ssm_parameter" "mandatory_tags" {
  name = "/${var.project_prefix}/component/config/output/mandatorytags/json"
}

data "aws_ssm_parameter" "account_short_name" {
  name = "/${var.project_prefix}/component/config/output/account-short-name"
}

locals {
  mandatory_tags = merge(
    tomap({ "project:meta:component" = local.component.name }),
    nonsensitive(jsondecode(data.aws_ssm_parameter.mandatory_tags.value))
  )
  account_short_name = nonsensitive(data.aws_ssm_parameter.account_short_name.value)

}
