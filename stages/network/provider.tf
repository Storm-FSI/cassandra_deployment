terraform {
  required_version = "1.4.4"
  required_providers {}
  backend "s3" {
    /*
    # Please enter the backend where the statefile will be stored. 
    # Recommended: Enable versioning for the S3 bucket to mistakes through human error.
    bucket = "dummy-project-ssm-parameter"
    key    = "key"
    region = "eu-central-1"
    */
  }
}
provider "aws" {
}
