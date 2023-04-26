variable "tags" {
  type        = map(string)
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "kms_key_description" {
  type        = string
  description = "Description for kms key"
}

variable "kms_key_alias" {
  type        = string
  description = "Kms Key Alias i.e. `alias/comp-session-manager-settings`"
}
variable "account_id"{
  type = string
}