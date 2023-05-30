resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.availability_zone
  size              = var.volume_size

  tags = {
    Name = "${var.maintainer}-ebs"
  }
}