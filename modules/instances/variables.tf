variable "name" {
  description = "Resource name"
  type        = string
}

variable "ssh_key_name" {
  type    = string
  default = "ssh-key-pair"
}

variable "vpc_id" {
  type = string
}

variable "bastion_subnet_id" {
  description = "Public Subnet ID to deploy the Bastion host"
  type        = string
}

variable "private_subnet_id" {
  description = "Public Subnet ID to deploy the Bastion host"
  type        = string
}

variable "bastion_sg_rules" {
  type = map(any)
  default = {}
}

variable "web_sg_rules" {
  type = map(any)
  default = {
    80 = {
      description = "HTTP public access",
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}