locals {

  component_name = "app-cassandra"

  component = {
    name             = "${var.project_prefix}-comp-tf-${local.component_name}"
    short_name       = local.component_name
    patch_group_name = "pg-${local.component_name}"
  }
}

module "kms" {
  source = "../../modules/kms"

  kms_key_description = "KMS Key for ${local.component.short_name}"
  kms_key_alias       = "alias/comp-${local.component.short_name}"

  tags = local.mandatory_tags

}
data "aws_ami" "default" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["${var.golden_image}"]
  }
}

resource "aws_security_group" "cassandra_access" {
  name        = "${local.component_name}-access"
  description = "Holder of this SG has access to ${local.component_name}"
  vpc_id      = local.vpc_id
  tags = merge(
    { Name = local.component_name },
    local.mandatory_tags
  )

}

resource "aws_ssm_parameter" "cassandra_access" {
  name  = "/${local.component.name}/access-sg"
  type  = "String"
  value = aws_security_group.cassandra_access.id
  tags  = local.mandatory_tags
}

# create the ec2 instance for the cassandra database
module "ec2" {
  source = "../../modules/ec2"
  ami    = data.aws_ami.default.id

  ec2_type = var.cassandra_instance 

  use_spot_instance = false

  asg_min_size         = 2
  asg_max_size         = 2
  asg_desired_capacity = 2

  vpc_id     = local.vpc_id
  subnet_ids = local.private_subnet_ids
  vpc_cidr   = local.vpc_cidr

  allowed_source_security_group_ids = [
    aws_security_group.cassandra_access.id,
  ]
  kms_key_arn = module.kms.arn
  key_name = data.aws_key_pair.cassandra_key_pair.key_name
  # this is limmited to 5-1=4 as per AWS rule
  # More securitygroups can be added as needed.
  security_groups = [
    //local.app_access_sg //only to showcase that more securitygroups can be added.
  ]
  bastion_sg = aws_security_group.cassandra_access.id

  component_name = local.component_name
  tags           = local.mandatory_tags

  root_block_device_kms_key_id  = module.kms.arn
  root_block_device_name        = data.aws_ami.default.root_device_name
  root_block_device_volume_size = 100
  root_block_device_volume_type = "gp3"

  addional_iam_policies = [
    //local.session_manager_policy //only to showcase that here additional policies can be added.
  ]

  alarm_sns_topic = local.alarm_sns_topic
}
