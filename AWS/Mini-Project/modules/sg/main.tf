locals {
  inbound_rules = [
    { port = 22, description = "SSH from all" },
    { port = 80, description = "HTTP from all" },
    { port = 443, description = "HTTPS from all" }
  ]
}


resource "aws_security_group" "security_group" {
  name        = "${var.maintainer}-sg"
  description = "Allow ssh, http and https inbound traffic"

  dynamic "ingress" {
    for_each = local.inbound_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.maintainer}-sg"
  }
}