resource "aws_instance" "bastion" {
  ami           = "ami-0889a44b331db0194" # amazon linux 2 on the us-east-1 region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.main.key_name
  subnet_id     = var.bastion_subnet_id
  vpc_security_group_ids = [aws_security_group.bastion.id]

  credit_specification {
    cpu_credits = "unlimited"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    private_key = tls_private_key.main.private_key_pem
  }

  provisioner "file" {
    destination = "/home/ec2-user/.ssh/id_rsa"
    content = tls_private_key.main.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 0600 /home/ec2-user/.ssh/id_rsa",
    ]
  }

  tags = {
    Name = "${var.name}-bastion-host"
  }

  depends_on = [ local_sensitive_file.pem_file ]
}
