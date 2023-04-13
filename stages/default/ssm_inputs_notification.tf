data "aws_ssm_parameter" "alarm_sns_topic" {
  name = "/${var.project_prefix}/component/notification/output/alarm-topic-arn"
}


locals {
  alarm_sns_topic = data.aws_ssm_parameter.alarm_sns_topic.value
}
