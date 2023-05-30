output "output_ec2_id" {
  value = aws_instance.ec2_instance.id
}

output "output_ec2_availability_zone" {
  value = aws_instance.ec2_instance.availability_zone
}
