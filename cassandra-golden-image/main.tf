provider "aws" {}

resource "aws_instance" "server1" {
  ami           = "ami-0821a7f11cb808cc6"
  instance_type = "t2.micro"
  key_name      = "virg"

  tags = {
    Name = "from-image"
  }
}