provider "aws" {
  region     = "us-east-1"
  access_key = "PUT YOUR OWN"
  secret_key = "PUT YOUR OWN"
}

terraform {
  backend "s3" {
    bucket     = "terraform-backend-xzo"
    key        = "xzo.tfstate"
    region     = "us-east-1"
    access_key = "PUT YOUR OWN"
    secret_key = "PUT YOUR OWN"
  }
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  tags            = var.aws_common_tag
  security_groups = ["${aws_security_group.allow_ssh_http_https.name}"]



  root_block_device {
    delete_on_termination = true
  }
}

resource "aws_security_group" "allow_ssh_http_https" {
  name        = "xzo-sg"
  description = "Allow ssh, http & https inbound traffic"


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh from VPC"
    from_port   = 20
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http_https"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true

  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${aws_eip.lb.public_ip}; ID : ${aws_instance.myec2.id} ; AZ :${aws_instance.myec2.availability_zone};"
  }
}

