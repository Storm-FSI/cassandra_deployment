# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
        terraform {
            required_version = "1.4.4"
            required_providers {}
            backend "s3" {
    
            # Please enter the backend where the statefile will be stored. 
            # Recommended: Enable versioning for the S3 bucket to mistakes through human error.
            
            bucket = "project-cassandra-cassandra-deployment"
            key    = "network/terraform.tfstate"
            region = "eu-central-1"
            
            }
        }
