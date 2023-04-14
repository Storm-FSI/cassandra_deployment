data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_prefix}/component/network/output/vpc/id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_prefix}/component/network/output/vpc/private-subnet/ids"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/${var.project_prefix}/component/network/output/vpc/cidr"
}

locals {
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  vpc_cidr = [
    nonsensitive(data.aws_ssm_parameter.vpc_cidr.value),
  ]
}
