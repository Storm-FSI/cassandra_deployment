# Creates a security group in the specified VPC, with the 
# specified name prefix and description
resource "aws_security_group" "default" {

  name_prefix = "${var.component_name}-"
  description = "Security group for ${var.component_name}"
  vpc_id      = var.vpc_id
  # Assigns tags to the security group, including a "Name" 
  # tag that identifies the component name
  tags = merge({ Name = "${var.component_name}" }, var.tags)
  # allow bastion traffic
  ingress {
    from_port = "22"
    to_port   = "22"
    protocol  = "tcp"

    security_groups = [
     "${var.bastion_sg}"
    ]
  }
}

# Creates an egress rule that allows all outbound traffic from the security group
resource "aws_security_group_rule" "allow_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
  # Associates the egress rule with the previously created security group
  security_group_id = aws_security_group.default.id
}

# Creates an ingress rule that allows internode traffic within the same security group
resource "aws_security_group_rule" "allow_nodes_traffic" {
  description = "Allow internode traffic"
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  # Associates the ingress rule with the previously created security 
  # group and allows traffic from the same security group
  security_group_id = aws_security_group.default.id
  self              = true
}

# Creates an ingress rule that allows traffic to the specified TCP port from the specified 
# security group(s)
resource "aws_security_group_rule" "allow_server_rpc_inbound" {
  count = length(var.allowed_source_security_group_ids)
  # Uses the count index to generate a description that specifies the source security group ID 
  # for each rule
  description = "SG ${element(var.allowed_source_security_group_ids, count.index)} is permitted access server rpc"
  type        = "ingress"
  protocol    = "tcp"
  from_port   = 9042
  to_port     = 9042
  # Associates the ingress rule with the previously created security group and 
  # specifies the allowed source security group(s)
  source_security_group_id = element(var.allowed_source_security_group_ids, count.index)
  security_group_id        = aws_security_group.default.id
}
