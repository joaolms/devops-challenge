# data "aws_availability_zones" "available" {
#   state = "available"
# }

# locals {
#   azs = slice(data.aws_availability_zones.available.names, 0, floor(var.n_subnets / 2))
# }

module "vpc" {
  source = "./modules/network"

  name         = var.name
  network_cidr = var.network_cidr
  n_subnets    = var.n_subnets

  # azs             = slice(data.aws_availability_zones.available.names, 0, var.n_subnets)
  # private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)
  # public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]

  tags = var.tags
}

locals {
  public_subnets = "teste"
}