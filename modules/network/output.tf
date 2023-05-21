output "Vpc_ID" {
  value = aws_vpc.main.id
}

output "Public_Subnets_CIDR" {
  value = aws_subnet.public[*].cidr_block
}

output "Private_Subnets_CIDR" {
  value = aws_subnet.private[*].cidr_block
}

output "Public_Subnets_ID" {
  value = aws_subnet.public[*].id
}

output "Private_Subnets_ID" {
  value = aws_subnet.private[*].id
}