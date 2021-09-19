output "mediawiki_server_ip" {
  value = aws_instance.mediawiki-server.public_ip
}