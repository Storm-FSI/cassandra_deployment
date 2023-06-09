## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.4.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.62.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ../../modules/ec2 | n/a |
| <a name="module_kms"></a> [kms](#module\_kms) | ../../modules/kms | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.cassandra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.cassandra_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ssm_parameter.cassandra_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ami.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_key_pair.cassandra_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/key_pair) | data source |
| [aws_ssm_parameter.mandatory_tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_alarm_sns_topic"></a> [alarm\_sns\_topic](#input\_alarm\_sns\_topic) | n/a | `string` | n/a | yes |
| <a name="input_cassandra_instance"></a> [cassandra\_instance](#input\_cassandra\_instance) | n/a | `string` | n/a | yes |
| <a name="input_golden_image"></a> [golden\_image](#input\_golden\_image) | Enter the ami id of the golden image that you created earlier. | `any` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Enter a public key name that will be used. This has to be in the AWS Account that you will provision the cassandra db to. | `string` | n/a | yes |
| <a name="input_mandatory_tags"></a> [mandatory\_tags](#input\_mandatory\_tags) | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | `map(any)` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | n/a | `list(any)` | n/a | yes |
| <a name="input_project_prefix"></a> [project\_prefix](#input\_project\_prefix) | Variable comming from the environement | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-central-1"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The vpc id of which the cassandra db will be deployed. | `any` | n/a | yes |

## Outputs

No outputs.
