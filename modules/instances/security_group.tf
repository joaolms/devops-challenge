data "http" "my_own_ip" {
  url = "http://ifconfig.me"
}

locals {
  bastion_sg_rules = {
    22 = {
      description = "SSH Access"
      protocol = "tcp"
      cidr_blocks = ["${data.http.my_own_ip.response_body}/32"]
    }
  }
}

resource "aws_security_group" "bastion" {
  name        = "${var.name}-sg-bastion"
  description = "Security group to bastion access"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = merge(local.bastion_sg_rules, var.bastion_sg_rules)
    content {
      description = ingress.value["description"]
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name}-sg-bastion"
  }
}

resource "aws_security_group" "web" {
  name        = "${var.name}-sg-web"
  description = "Security group to web access"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.web_sg_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  ingress {
    description     = "Bastion host SSH access"
    protocol        = "tcp"
    from_port       = "22"
    to_port         = "22"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name}-sg-web"
  }
}