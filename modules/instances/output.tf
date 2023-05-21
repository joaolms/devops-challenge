# output "ssh_private_key" {
#     value = tls_private_key.this
#     sensitive = true
# }

# output "key_pair" {
#     value = aws_key_pair.this
# }

output "Bastion_Public_IP" {
  value = aws_instance.bastion.public_ip
}
