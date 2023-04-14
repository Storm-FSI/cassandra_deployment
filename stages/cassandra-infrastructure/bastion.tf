data "aws_key_pair" "cassandra_key_pair" {
  key_name = var.key_name
}
resource "aws_instance" "cassandra" {
  ami           = "ami-08f54b258788948e1"   // Replace with the AMI of your choice
  instance_type = "t2.micro"

  subnet_id          = "${element(local.private_subnet_ids, 1)}"
  vpc_security_group_ids = ["${aws_security_group.cassandra_access.id}"]
  associate_public_ip_address = true
  key_name = data.aws_key_pair.cassandra_key_pair.key_name
  tags = {
    Name = "cassandra-bastion"
  }
}
