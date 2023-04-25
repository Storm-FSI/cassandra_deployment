# Network input parameters-------------------------------------------------------------------
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_prefix}/component/network/output/vpc/id"
  type  = "String"
  value = aws_vpc.main.id
}
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_prefix}/component/network/output/vpc/private-subnet/ids"
  type  = "String"
  value = join(",", aws_subnet.private.*.id)
}

# Config input parameters------------------------------------------------------
resource "aws_ssm_parameter" "mandatory_tags" {
  name  = "/${var.project_prefix}/component/config/output/mandatorytags/json"
  type  = "String"
  value = jsonencode({
    Owner    = "ownername"
    Opsteam  = "opsteamname"
    project  = "projectname"
  })

}
