variable "project_prefix" {
  type = string
  description = "Variable comming from the environement"
}
variable "account_id" {
  type = string
  description = "the account id the network should be deployed in."
}
variable "account_short_name"{
  type = string
  description = "the account shortname the network should be deployed in."
}
variable "vpc_cidr"{
  type = string
  description = "the vpc cidr to create a vpc"
}