output "Bastion_Host_IP_address" {
  value = aws_instance.bastion.public_ip
}

output "Private_Instances_IP_addresses" {
  value = aws_instance.web[*].private_ip
}

output "Load_balancer_HTTP_DNS" {
  value = aws_lb.this.dns_name
}

output "SSH_key_content" {
  value = aws_key_pair.main.key_name
}
