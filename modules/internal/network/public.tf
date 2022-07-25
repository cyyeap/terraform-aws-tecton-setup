resource "aws_subnet" "public" {
  count = var.enable_public_subnets ? var.availability_zone_count : 0

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(local.public_cidr_block, 10, count.index)
  vpc_id            = local.vpc_id

  tags = merge(local.tags, {
    Name = "${local.deployment_name}-public",
  })
}

resource "aws_route_table" "public" {
  count = var.enable_public_subnets ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(local.tags, {
    Name = "${local.deployment_name}-public",
  })

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc[0].id
  }
}

resource "aws_route_table_association" "public" {
  count = var.enable_public_subnets ? var.availability_zone_count : 0

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_internet_gateway" "vpc" {
  // only create the IG if enable_public_subnets is set to true
  //   OR we do not have nat_gateways_by_az
  //   as nat_gateway resources depend on this IG
  count = var.enable_public_subnets || !local.has_nat_gateways_by_az ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(local.tags, {
    Name = local.deployment_name
  })
}
