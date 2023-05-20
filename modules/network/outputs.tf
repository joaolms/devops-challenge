output "Public_Subnets_CIDR" {
  value = aws_subnet.public[*].cidr_block
}

output "Private_Subnets_CIDR" {
  value = aws_subnet.private[*].cidr_block
}

output "availability_zones" {
  value = local.availability_zone
}