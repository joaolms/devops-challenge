output "Network" {
  value = module.vpc.Network
}

output "Load_blanacer_HTTP_Content" {
  value = module.instances.Load_blanacer_HTTP_Content
}

output "Bastion_Host_IP" {
  value = module.instances.Bastion_Host_IP
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
