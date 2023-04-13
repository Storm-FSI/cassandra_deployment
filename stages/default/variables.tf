variable "project_prefix" {
  default     = "projectprefix"
  description = "Variable comming from the environement"
}
 
variable "cassandra_instance" {
  type = string
  default = "t2.medium"
}

variable "key_name"{
  type = string
  description = "Enter a public key that will be used. This has to be on the AWS Account that you will provision the cassandra db."
}

variable "region" {
  default = "eu-central-1"
}
variable "golden_image" {
  description = "Enter the ami id of the golden image that you created earlier."
}