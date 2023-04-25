
data "aws_ssm_parameter" "mandatory_tags" {
  name = "/${var.project_prefix}/component/config/output/mandatorytags/json"
}

locals {
  mandatory_tags = merge(
    tomap({ "project:meta:component" = local.component.name }),
    nonsensitive(jsondecode(data.aws_ssm_parameter.mandatory_tags.value))
  )
}
