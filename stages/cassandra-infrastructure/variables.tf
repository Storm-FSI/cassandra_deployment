variable "project_prefix" {
  description = "Variable comming from the environement"
}
 
variable "cassandra_instance" {
  type = string
  default = "t2.medium"
}

variable "key_name"{
  type = string
  description = "Enter a public key name that will be used. This has to be in the AWS Account that you will provision the cassandra db to."
}

variable "region" {
  default = "eu-central-1"
}
variable "golden_image" {
  description = "Enter the ami id of the golden image that you created earlier."
}