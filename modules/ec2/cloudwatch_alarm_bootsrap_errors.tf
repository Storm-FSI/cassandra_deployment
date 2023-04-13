locals {
  metric_log_group_name = "${title(var.component_name)}/var/log/bootstrap/errors.log"
  metric_namespace      = title(var.component_name)
  metric_value          = "1"
  metric_name           = "bootstrap_errors"
  metric_filter_name    = "${title(var.component_name)}_Bootstrap_Errors"
  # Ref: https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html
  metric_pattern = "\"!^Created symlink from /etc/systemd/system/multi-user.target.wants\"" # The filter pattern "" matches all log events.
  alarm_name                = "${title(var.component_name)}_Bootstrap_Errors"
  alarm_description         = "Detects entries in ${local.metric_log_group_name}"
  alarm_action_arns         = [var.alarm_sns_topic]
  alarm_period              = "3600"
  alarm_threshold           = "1"
  alarm_statistic           = "Sum"
  alarm_comparison_operator = "GreaterThanThreshold"
  alarm_evaluation_periods  = "1"

}

# The cloudwatch log group to log bootstrap related errors.
resource "aws_cloudwatch_log_group" "bootstrap_errors" {
  name              = local.metric_log_group_name
  retention_in_days = "14"

  # in this case it is one of plenty of other loggroups
  # so we let tf-cloudwatch handle the loggroups encryption
  lifecycle {
    ignore_changes = [
      kms_key_id,
    ]
  }

}

# AWS CloudWatch metric filter that is used to extract data from a 
# specified log group and send it to a custom metric in AWS CloudWatch.
resource "aws_cloudwatch_log_metric_filter" "bootstrap_filter" {
  log_group_name = aws_cloudwatch_log_group.bootstrap_errors.name
  metric_transformation {
    name      = local.metric_name
    namespace = local.metric_namespace
    value     = local.metric_value
  }
  name    = local.metric_filter_name
  pattern = local.metric_pattern
}

# AWS CloudWatch metric alarm that is triggered when a specified metric crosses a threshold defined in the 
# locals section.
resource "aws_cloudwatch_metric_alarm" "bootstrap_alarm" {
  alarm_name          = local.alarm_name
  alarm_description   = local.alarm_description
  comparison_operator = local.alarm_comparison_operator
  evaluation_periods  = local.alarm_evaluation_periods
  metric_name         = aws_cloudwatch_log_metric_filter.bootstrap_filter.name
  namespace           = local.metric_namespace
  period              = local.alarm_period
  threshold           = local.alarm_threshold
  statistic           = local.alarm_statistic
  alarm_actions       = local.alarm_action_arns
}
