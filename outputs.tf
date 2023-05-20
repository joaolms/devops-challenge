output "Public_Subnets_CIDR" {
  value = module.vpc.Public_Subnets_CIDR
}

output "Private_Subnets_CIDR" {
  value = module.vpc.Private_Subnets_CIDR
}
