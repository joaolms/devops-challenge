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
  tags         = var.tags
}

module "instances" {
  source = "./modules/instances"

  name              = var.name
  vpc_id            = module.vpc.Vpc_ID
  bastion_subnet_id = module.vpc.Public_Subnets_ID[0]
}
