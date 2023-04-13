locals {
  dashboard_body_content = templatefile("${path.module}/templates/asg_dashboard.json", {
    AUTOSCALING_GROUP_NAME = aws_autoscaling_group.default.name
    COMPONENT_NAME         = title(var.component_name)
  })
}

#The Cloudwatch dashboard to monitor the autoscalinggroup
resource "aws_cloudwatch_dashboard" "default" {

  dashboard_name = title(var.component_name)
  dashboard_body = local.dashboard_body_content

}
