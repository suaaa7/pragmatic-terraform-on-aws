variable "vpc" {}

variable "project" {
  default = "batch"
}

resource "aws_security_group" "fargate" {
  name = var.project
  vpc_id = var.vpc

  tags = {
    Name = var.project
  }
}

resource "aws_security_group_rule" "fargate_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.fargate.id
}

output "fargate_security_group" {
  value = aws_security_group.fargate.id
}
