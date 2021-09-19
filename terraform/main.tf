
data "http" "myip" { #to fetch this system's public ip
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "mediawiki-sg" {
  name   = "mediawiki-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Ingress for SSH only from the terraform workstation"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"] #allowing only this system's ip for port 22.
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Ingress for All over the world"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mediawiki-server" {
  ami                         = var.ami_id
  subnet_id                   = var.ec2_subnet_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.mediawiki-sg.id]
  key_name                    = var.ec2_pem_path
  tags = {
    "Application" = "MediaWiki"
    "Name"        = "mediawiki-server"
  }
  provisioner "remote-exec" {
    inline = ["echo 'checking ec2 instance is up ...'"]

    connection {
      type        = "ssh"
      user        = var.ec2_remote_user
      private_key = file(var.pem_key_path)
      host        = aws_instance.mediawiki-server.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.mediawiki-server.public_ip}, --private-key ${var.pem_key_path} ${var.playbook_path} --ask-vault-pass"
  }
}
