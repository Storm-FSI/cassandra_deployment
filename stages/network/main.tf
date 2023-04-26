# Network resources-------------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr //"192.168.0.0/24"
  tags = {
    Name = "${var.project_prefix}-vpc"
  }
}
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  # Create four subnets within the 192.168.0.0/24 VPC CIDR block, with each subnet having a /28 CIDR block.
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index + 1)   
  # Create four subnet resources by repeating this block four times.
  count = 4
  tags = {
    Name = "${var.project_prefix}-subnet-${count.index}"
  }
}
# Create a internetgateway 
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_prefix}-internetgateway"
  }
}
resource "aws_route_table" "routetable_internetaccess" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "${var.project_prefix}-internet-access"
  }
}
resource "aws_route_table_association" "subnet_1_internetaccess" {
  subnet_id      = aws_subnet.private[1].id
  route_table_id = aws_route_table.routetable_internetaccess.id
}
# Notification resources and input parameters------------------------------------------------------
# Create SNS topic
resource "aws_sns_topic" "alarm_sns_topic" {
  name = "bootstrap_alarm_sns_topic"
}

