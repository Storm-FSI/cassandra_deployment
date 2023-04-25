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

/*resource "aws_ssm_parameter" "vpc_cidr" {
  name  = "/${var.project_prefix}/component/network/output/vpc/cidr"
  type  = "String"
  value = aws_vpc.main.cidr_block
}*/
# Config input parameters------------------------------------------------------
/*resource "aws_ssm_parameter" "account_short_name" {
  name  = "/${var.project_prefix}/component/config/output/account-short-name"
  type  = "String"
  value = var.account_short_name
  }
*/
/*resource "aws_ssm_parameter" "mandatory_tags" {
  name  = "/${var.project_prefix}/component/config/output/mandatorytags/json"
  type  = "String"
  value = jsonencode({
    Owner    = "ownername"
    Opsteam  = "opsteamname"
    project  = "projectname"
  })
}
*/
# Notification resources and input parameters------------------------------------------------------
/*resource "aws_ssm_parameter" "alarm_sns_topic" {
  name        = "/${var.project_prefix}/component/notification/output/alarm-topic-arn"
  description = "Parameter for alarm SNS topic ARN"
  type        = "String"
  value       = "${aws_sns_topic.alarm_sns_topic.arn}"
  depends_on = [aws_ssm_parameter.alarm_sns_topic]
}*/
