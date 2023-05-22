output "Network" {
  value = module.vpc.Network
}

output "Alb_Dns_Name" {
  value = module.instances.Alb_Dns_Name
}

output "Bastion_Host_IP" {
  value = module.instances.Bastion_Host_IP
}

