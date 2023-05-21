output "Vpc_ID" {
  value = module.vpc.Vpc_ID
}

output "Public_Subnets_CIDR" {
  value = module.vpc.Public_Subnets_CIDR
}

output "Private_Subnets_CIDR" {
  value = module.vpc.Private_Subnets_CIDR
}

output "Public_Subnets_ID" {
  value = module.vpc.Public_Subnets_ID
}

output "Private_Subnets_ID" {
  value = module.vpc.Private_Subnets_ID
}

# output "SSH_Private_Key" {
#   value = module.instances.ssh_private_key.private_key_pem
#   sensitive = true
# }

# output "Key_Pair" {
#   value = module.instances.key_pair
# }