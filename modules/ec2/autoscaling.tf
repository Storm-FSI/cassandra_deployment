locals {
  asg_tags = merge(
    var.tags,
    { "Name" = var.component_name },
    { "cassandra-cluster" = "app-cassandra" },
  )
  asg_name = "${var.component_name}-${aws_launch_template.default.latest_version}"
}
/*
# creating cassandra encrypted parameter in ssm parameterstore
resource "aws_ssm_parameter" "cassandra_cluster" {
  name   = "/${var.component_name}/cassandra-cluster-tag-value"
  type   = "SecureString"
  key_id = var.kms_key_arn
  value  = "app-cassandra"
  tags   = var.tags
}
*/
# creating a autoscalinggroup which will have 3 EC2 instances with cassandra 
# installed on them. The autoscalinggroup uses the asg_launch_template. 
resource "aws_autoscaling_group" "default" {
  name                      = local.asg_name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.asg_desired_capacity
  force_delete              = false

  launch_template {
    id      = aws_launch_template.default.id
    version = aws_launch_template.default.latest_version
  }

  vpc_zone_identifier = var.subnet_ids

  metrics_granularity = "1Minute"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  termination_policies = [
    "OldestInstance",
    "ClosestToNextInstanceHour",
  ]

  dynamic "tag" {
    for_each = local.asg_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  timeouts {
    delete = "15m"
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_cloudwatch_metric_alarm" "default" {
  alarm_name          = "${local.asg_name}-instance-count"
  alarm_description   = "There are currently fewer Instances in this asg as needed."
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "GroupTotalInstances"
  namespace           = "AWS/AutoScaling"
  period              = "60"
  statistic           = "Average"
  threshold           = var.asg_min_size
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.default.name
  }
}
