resource "aws_network_interface" "bastion" {
  subnet_id       = var.bastion_subnet_id
  security_groups = [aws_security_group.bastion.id]
  tags = {
    Name = "${var.name}-bastion-public-interface"
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-0889a44b331db0194" # amazon linux 2 on the us-east-1 region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.main.key_name

  network_interface {
    network_interface_id = aws_network_interface.bastion.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "${var.name}-bastion-host"
  }
}
