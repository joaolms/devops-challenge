data "aws_caller_identity" "current" {}

data "aws_ami" "golden_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.name}-webserver-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # Canonical
}

resource "aws_instance" "web" {
  count         = length(var.private_subnet_ids)
  ami           = data.aws_ami.golden_image.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.main.key_name
  subnet_id     = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.web.id]

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = merge(var.tags, {
    Name = "${var.name}-web-${count.index}"
  })
}
