![cassandra drawio](https://user-images.githubusercontent.com/114674790/231321362-51dfae25-8663-4c72-95f7-84278d1d499b.png)

This is a cassandra deployment to showcase the expertise in Terraform, packer and bash.

# Getting started
The objective of this project is to showcase the deployment of a Cassandra database in a scalable manner. The project focuses on deploying a simple Cassandra database within an autoscaling group. The Cassandra image used in this project was created with Packer, an image creation tool. To monitor the cassandra databases a cloudwatch dashboard will be provisioned as well.

# Deployment Steps
To deploy the Cassandra database, there are three main steps that need to be followed.

The first step involves creating a golden image that automates the installation of the Cassandra DB software. This is an important step in the deployment process as it ensures that the software is installed consistently and efficiently throught the autoscalinggroup.

The second step is to deploy the network environment to set up the necessary network resources for the Cassandra deployment. This step involves configuring the network to ensure that the Cassandra database can communicate with other nodes in the cluster.

The final step is to deploy the default environment located in stages for the Cassandra deployment. This involves configuring the database and getting it ready to use.

## 1) Create yourself a goldenimage for cassandra:
 - The image will be created in the eu-central-1 region, and a standard Amazon Linux 2 image will be used as a source AMI.
 - Ensure that you have a default VPC set up since Packer will use it to create a temporary EC2 instance.
 - From the EC2 instance, Packer will create an AMI that you will need to use.
 - you will need to be logged in an aws account through the aws cli.
 In the cassandra-image directory, run the following commands:
```
packer init .                          # to initialize the Packer configuration
packer fmt .                           # to format the configuration files
packer validate .                      # to validate the configuration files
packer build cassandra-image.pkr.hcl   # to start the image creation process.
```
## 2) Deploy the network environment:
To deploy the network environment, follow the steps below:
- Note that this deployment will use the default profile saved in ~/.aws.
Run the following commands:
```
terraform init  
```
To initialize the Terraform configuration. You will need to specify the location where your Terraform state file will be stored. Here is an example input:
```
bucket = "terraform-bucket-name"
key    = "key"
region = "eu-central-1"
```
To apply the Terraform configuration and deploy the Cassandra database.
```
terraform apply 
```
## 3) Deploy the cassandra environment:
To deploy the Cassandra database, follow the steps below:
- Note that this deployment will use the default profile saved in ~/.aws.
Run the following commands:
```
terraform init  
```
To initialize the Terraform configuration. You will need to specify the location where your Terraform state file will be stored. Here is an example input:
```
bucket = "terraform-bucket-name"
key    = "key"
region = "eu-central-1"
```
To apply the Terraform configuration and deploy the Cassandra database.
```
terraform apply 
```
