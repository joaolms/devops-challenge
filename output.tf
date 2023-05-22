output "Network" {
  value = module.vpc.Network
}

output "Load_balancer_HTTP_DNS" {
  value = module.instances.Load_balancer_HTTP_DNS
}

output "Bastion_Host_IP_address" {
  value = module.instances.Bastion_Host_IP_address
}

output "Private_Instances_IP_addresses" {
  value = module.instances.Private_Instances_IP_addresses
}

output "Usernames" {
  value = "ec2-user"
}

# output "SSH_key_content" {
#   value = file("./${var.name}-ssh-key-pair.pem")
# }

output "SSH_key_content" {
  value = module.instances.SSH_key_content
}

output "Manifest" {
  value = module.golden_image.Manifest
}