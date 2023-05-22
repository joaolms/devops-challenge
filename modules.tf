module "vpc" {
  source = "./modules/network"

  name         = var.name
  network_cidr = var.network_cidr
  n_subnets    = var.n_subnets
  tags         = var.tags
}

module "golden_image" {
  source = "./modules/golden_image"

  manifest_path = var.manifest_path
}

module "instances" {
  source = "./modules/instances"

  name               = var.name
  vpc_id             = module.vpc.Vpc_ID
  bastion_subnet_id  = module.vpc.Public_Subnets_ID[0]
  private_subnet_ids = module.vpc.Private_Subnets_ID
  public_subnet_ids  = module.vpc.Public_Subnets_ID
  tags               = var.tags

  depends_on = [ module.vpc, module.golden_image ]
}
