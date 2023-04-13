data "aws_caller_identity" "current" {
}
//This will ensure that the default profile will be used to login to your aws account.
provider "aws" {
}
