# generating backend.tf and provider.tf
generate "backend" {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
        terraform {
            required_version = "1.4.4"
            required_providers {}
            backend "s3" {
    
            # Please enter the backend where the statefile will be stored. 
            # Recommended: Enable versioning for the S3 bucket to mistakes through human error.
            
            bucket = "project-cassandra-cassandra-deployment" #TODO
            key    = "${path_relative_to_include()}/terraform.tfstate" #TODO
            region = "eu-central-1" #TODO
            
            }
        }
    EOF
}
generate "provider"{
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
        /*
        This will ensure that the default profile will be used to login to your aws account.
        Here, you can also mention a custom profile of your liking.
        */
        provider "aws" {}
        
    EOF    
} 
/*
Reason: als bestpractice forcieren #todoo
*/
generate "outputs"{
    path = "outputs.tf"
    if_exists = "skip" # use "overwrite_terragrunt" if you want to add something to the outputs.tf on this level 
    contents = <<EOF
        /*
        Add your outputs of this template here, if needed
        Some important Conventions to take in consideration:
        - consideration 1
        - consideration 2
        */
        
        
    EOF    
} 
generate "variables" {
    path = "variables.tf"
    if_exists = "skip" # use "overwrite_terragrunt"  if you want to add something to the outputs.tf on this level 
    contents = <<EOF
        /*
        Add your variables of this template here.
        Some important Conventions to take in consideration:
        - use variable names which are self explanatory 
        */
        
        
    EOF    
}
/*
    To centrally set parameters that are important for the whole deployment here is the input block.
    Please set all variables.
*/
locals {
    project_prefix = "project-cassandra" #TODO
    current_account_id = "${get_aws_account_id()}"
    component = "app-cassandra" #TODO
    //Be aware: This Deployment uses a Role name SysAdmin that holds policies of an systemadmin #TODO
}
inputs = {
    # general setup ----------------------------------------------------------------------------
    account_id = "${local.current_account_id}" 
    account_short_name = "dev-${local.project_prefix}" #TODO
    project_prefix = "${local.project_prefix}" 
    region = "eu-central-1" #TODO

    # network setup ----------------------------------------------------------------------------
    vpc_name = "${local.project_prefix}-dummy-vpc" #TODO
    vpc_cidr = "192.168.0.0/24" #TODO
    # For this deployment the number of subnets are set to 4. 

    # cassandra related setup ------------------------------------------------------------------
    # The ami id of the golden image created with packer.
    golden_image = "ami-029f7dca56afcedcd" #TODO
    cassandra_instance = "t2.medium" #TODO
    # Enter a public key name that will be used. 
    # This has to be in the AWS Account that you will provision the cassandra db to.
    key_name = "cassandra" #TODO             

    # tag setup --------------------------------------------------------------------------------
    mandatory_tags = jsonencode({
        environment = "dev" 
        terraform = "true" 
        opsteam = "A-Team" 
  })
    
}
