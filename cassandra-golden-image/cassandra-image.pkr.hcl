packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-image"
  instance_type = "t2.micro"
  region        = "eu-central-1"
  source_ami    = "ami-08f54b258788948e1"
  ssh_username  = "ec2-user"
}
build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "file" {
    source      = "provisioners/file/cassandra.service"
    destination = "/tmp/"
  }
  provisioner "shell" {
    script  = "provisioners/shell/install-cassandra.sh"
    timeout = "380s"
  }
}