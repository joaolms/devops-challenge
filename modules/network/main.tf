data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  public_subnets    = [for pub_subnets in cidrsubnets(var.network_cidr, 1, 1) : cidrsubnets(pub_subnets, 2, 2, 2)][0]
  private_subnets   = [for priv_subnets in cidrsubnets(var.network_cidr, 1, 1) : cidrsubnets(priv_subnets, 2, 2, 2)][1]
  availability_zone = data.aws_availability_zones.available.names
}

resource "aws_vpc" "main" {
  cidr_block           = var.network_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(var.tags, {})
}


##### PUBLIC NETWORK #####

resource "aws_subnet" "public" {
  count                   = floor(var.n_subnets / 2)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnets[count.index]
  availability_zone       = local.availability_zone[count.index]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    "Name" = "${var.name}-public-subnet-${local.availability_zone[count.index]}"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, {
    Name = "${var.name}-internet-gateway"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, {
    "Name" = "${var.name}-pub-subnets-route-table"
  })
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public[*].id)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}


##### PRIVATE NETWORK #####

resource "aws_subnet" "private" {
  count                   = ceil(var.n_subnets / 2)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.private_subnets[count.index]
  availability_zone       = local.availability_zone[count.index]
  map_public_ip_on_launch = false
  tags = merge(var.tags, {
    "Name" = "${var.name}-private-subnet-${local.availability_zone[count.index]}"
  })
}

resource "aws_eip" "nat_gateway" {
  vpc = true
  tags = merge(var.tags, {
    Name = "${var.name}-nat-gateway-eip"
  })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_gateway.allocation_id
  subnet_id     = aws_subnet.public[0].id
  tags = merge(var.tags, {
    Name = "${var.name}-nat-gateway"
  })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(var.tags, {
    "Name" = "${var.name}-priv-subnets-route-table"
  })
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private[*].id)

  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}
