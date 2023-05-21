resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "main" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.main.public_key_openssh
  lifecycle {
    create_before_destroy = true
  }
}

resource "local_sensitive_file" "pem_file" {
  filename             = pathexpand("ssh-key-pair.pem")
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.main.private_key_pem
}
