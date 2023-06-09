## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_cloudwatch_dashboard.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_cloudwatch_log_group.bootstrap_errors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_metric_filter.bootstrap_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.bootstrap_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_instance_profile.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_cw_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_nodes_traffic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_server_rpc_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addional_iam_policies"></a> [addional\_iam\_policies](#input\_addional\_iam\_policies) | Addional IAM policies to be added to the instance | `list(string)` | `[]` | no |
| <a name="input_addional_log_paths"></a> [addional\_log\_paths](#input\_addional\_log\_paths) | n/a | `list(any)` | `[]` | no |
| <a name="input_alarm_sns_topic"></a> [alarm\_sns\_topic](#input\_alarm\_sns\_topic) | n/a | `string` | n/a | yes |
| <a name="input_allowed_source_security_group_ids"></a> [allowed\_source\_security\_group\_ids](#input\_allowed\_source\_security\_group\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI where to start the proxies from | `string` | n/a | yes |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | Autoscaling desired capacity | `number` | n/a | yes |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Autoscaling maximum size | `number` | n/a | yes |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Autoscaling minimum size | `number` | n/a | yes |
| <a name="input_bastion_sg"></a> [bastion\_sg](#input\_bastion\_sg) | n/a | `string` | n/a | yes |
| <a name="input_component_name"></a> [component\_name](#input\_component\_name) | composed component name (e.g. `coma-dev-bastionhost`) | `string` | n/a | yes |
| <a name="input_ec2_type"></a> [ec2\_type](#input\_ec2\_type) | EC2 instance type | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH key to use | `string` | `""` | no |
| <a name="input_root_block_device_kms_key_id"></a> [root\_block\_device\_kms\_key\_id](#input\_root\_block\_device\_kms\_key\_id) | The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted volume | `string` | n/a | yes |
| <a name="input_root_block_device_name"></a> [root\_block\_device\_name](#input\_root\_block\_device\_name) | The name of the device to mount. | `string` | n/a | yes |
| <a name="input_root_block_device_volume_iops"></a> [root\_block\_device\_volume\_iops](#input\_root\_block\_device\_volume\_iops) | The amount of provisioned IOPS. This must be set with a volume\_type of io1/io2 | `number` | `null` | no |
| <a name="input_root_block_device_volume_size"></a> [root\_block\_device\_volume\_size](#input\_root\_block\_device\_volume\_size) | The size of the volume in gigabytes. | `number` | n/a | yes |
| <a name="input_root_block_device_volume_type"></a> [root\_block\_device\_volume\_type](#input\_root\_block\_device\_volume\_type) | The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp3). | `string` | `"gp3"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security Groups for this Instance | `list(any)` | n/a | yes |
| <a name="input_ssm_iam_policy"></a> [ssm\_iam\_policy](#input\_ssm\_iam\_policy) | ssm\_policy | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet where to create the instance | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | `map(any)` | n/a | yes |
| <a name="input_use_spot_instance"></a> [use\_spot\_instance](#input\_use\_spot\_instance) | n/a | `bool` | `false` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC where to create the instance | `string` | n/a | yes |

## Outputs

No outputs.
