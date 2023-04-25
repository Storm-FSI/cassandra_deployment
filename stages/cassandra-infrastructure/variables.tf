variable "project_prefix" {
  description = "Variable comming from the environement"
}
 
variable "cassandra_instance" {
  type = string
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
variable "vpc_id" {
  description = "The vpc id of which the cassandra db will be deployed."
}
variable "vpc_cidr"{
  
}
variable "alarm_sns_topic" {

}
variable "private_subnet_ids" {
  
}