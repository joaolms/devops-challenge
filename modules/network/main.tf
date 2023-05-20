data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  public_subnets    = [for pub_subnets in cidrsubnets(var.network_cidr, 1,1) : cidrsubnets(pub_subnets, 2, 2, 2)][0]
  private_subnets   = [for priv_subnets in cidrsubnets(var.network_cidr, 1,1) : cidrsubnets(priv_subnets, 2, 2, 2)][1]
  availability_zone = slice(data.aws_availability_zones.available.names, 0, floor(var.n_subnets / 2))
  default_tags = {
    "Name" = "${var.name}-vpc",
    "environment" = var.environment
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.network_cidr
  tags       = merge(local.default_tags, var.tags)
}

resource "aws_subnet" "public" {
  count      = floor(var.n_subnets/2)
  vpc_id     = aws_vpc.main.id
  cidr_block = local.public_subnets[count.index]
  availability_zone = local.availability_zone[count.index]
  tags = {
    "Name" = "${var.name}-public-subnet-${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count      = floor(var.n_subnets/2)
  vpc_id     = aws_vpc.main.id
  cidr_block = local.private_subnets[count.index]
  availability_zone = local.availability_zone[count.index]
  tags = {
    "Name" = "${var.name}-private-subnet-${count.index+1}"
  }
}
