output "Bastion_Host_IP" {
  value = aws_instance.bastion.public_ip
}

output "Private_Instances_IP_addresses" {
  value = aws_instance.web[*].private_ip
}

output "Load_blanacer_HTTP_Content" {
  value = aws_lb.this.dns_name
}

output "SSH_key_content" {
  value = aws_key_pair.main.key_name
}
