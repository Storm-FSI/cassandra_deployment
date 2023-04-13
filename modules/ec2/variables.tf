variable "ami" {
  description = "The AMI where to start the proxies from"
  type        = string
}

variable "ec2_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
  type        = string
}

variable "key_name" {
  description = "SSH key to use"
  default     = ""
  type        = string
}

variable "subnet_ids" {
  description = "Subnet where to create the instance"
  type        = list(any)
}

variable "vpc_id" {
  description = "VPC where to create the instance"
  type        = string
}

variable "security_groups" {
  description = "Security Groups for this Instance"
  type        = list(any)
}

variable "ssm_iam_policy" {
  description = "ssm_policy"
  type        = string
  default     = ""
}

variable "addional_iam_policies" {
  description = "Addional IAM policies to be added to the instance"
  type        = list(string)
  default     = []
}


variable "tags" {
  type        = map(any)
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "asg_min_size" {
  type        = number
  description = "Autoscaling minimum size"
}

variable "asg_max_size" {
  type        = number
  description = "Autoscaling maximum size"
}

variable "asg_desired_capacity" {
  type        = number
  description = "Autoscaling desired capacity"
}

variable "component_name" {
  type        = string
  description = "composed component name (e.g. `coma-dev-bastionhost`)"
}

variable "root_block_device_kms_key_id" {
  type        = string
  description = "The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted volume"
}

variable "root_block_device_name" {
  type        = string
  description = "The name of the device to mount."
}

variable "root_block_device_volume_size" {
  type        = number
  description = "The size of the volume in gigabytes."
}

variable "root_block_device_volume_type" {
  type        = string
  default     = "gp3"
  description = "The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp3)."
}

variable "root_block_device_volume_iops" {
  type        = number
  default     = null
  description = "The amount of provisioned IOPS. This must be set with a volume_type of io1/io2"
}

variable "addional_log_paths" {
  type    = list(any)
  default = []
}

variable "alarm_sns_topic" {
  type = string
}


variable "use_spot_instance" {
  type    = bool
  default = false
}

variable "allowed_source_security_group_ids" {
  type = list(string)
}

variable "kms_key_arn" {
  type = string
}

variable "vpc_cidr" {
  type = list(any)
}
variable "bastion_sg" {
  type = string
}