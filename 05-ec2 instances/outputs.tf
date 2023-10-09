output "aws_security_group_http_sever_details" {
  value = aws_security_group.http_server_sg
}

output "http_server_public_dns" {
  value = aws_instance.http_server.public_dns
}


output "default_subnet_id" {
  value = aws_default_subnet.default.id
}
