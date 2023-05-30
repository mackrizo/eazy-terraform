output "output_elastic_ip" {
  value = aws_eip.elastic_ip.public_ip
}

output "output_elastic_id" {
  value = aws_eip.elastic_ip.id
}
