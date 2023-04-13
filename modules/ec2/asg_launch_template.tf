# The launchtemplate used by the autoscalinggroup to deploy and spin up EC2 
# instances with a cassandra installation
resource "aws_launch_template" "default" {

  name_prefix = var.component_name
  description = "${title(var.component_name)}'s LaunchTemplate"

  image_id      = var.ami
  instance_type = var.ec2_type

  iam_instance_profile {
    name = aws_iam_instance_profile.default.name
  }
  
  monitoring {
    enabled = true
  }
  key_name = var.key_name
  vpc_security_group_ids = toset(concat([aws_security_group.default.id], var.security_groups))

  block_device_mappings {
    device_name = var.root_block_device_name
    ebs {
      volume_size = var.root_block_device_volume_size
      encrypted   = true
      kms_key_id  = var.root_block_device_kms_key_id
      volume_type = var.root_block_device_volume_type
      iops        = var.root_block_device_volume_iops
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "optional"
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(var.tags, {
      "Name" = var.component_name
    })
  }

  tags = var.tags

}
