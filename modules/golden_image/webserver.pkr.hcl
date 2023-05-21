packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.5"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon" {
  ami_name      = "galp-webserver-v{{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  ssh_username = "ec2-user"
}

build {
  name = "galp-webserver"
  sources = [
    "source.amazon-ebs.amazon"
  ]
  provisioner "shell" {
    environment_vars = []
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl enable httpd",
      "echo Hello World at $(date +%F) | sudo tee /var/www/html/index.html",
      "sudo systemctl start httpd",
    ]
  }
}
