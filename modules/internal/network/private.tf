resource "aws_subnet" "private" {
  count = local.availability_zone_count

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(local.private_cidr_block, 3, count.index)
  vpc_id            = local.vpc_id

  tags = merge(local.tags, {
    "Name" = "${local.deployment_name}-private",
  })
}

resource "aws_route_table_association" "private" {
  count = local.availability_zone_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table" "private" {
  count  = local.availability_zone_count
  vpc_id = local.vpc_id

  tags = merge(local.tags, {
    "Name" = "${local.deployment_name}-private",
  })
}

resource "aws_route" "private_to_nat_gateway" {
  count = local.availability_zone_count

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = local.has_nat_gateways_by_az ? var.nat_gateways_by_az[
    data.aws_availability_zones.available.names[count.index]
  ] : aws_nat_gateway.vpc[count.index].id
}

resource "aws_nat_gateway" "vpc" {
  count = local.has_nat_gateways_by_az ? 0 : local.availability_zone_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = merge(local.tags, {
    "Name" = local.deployment_name
  })
  depends_on = [aws_internet_gateway.vpc]
}

resource "aws_eip" "nat" {
  count = local.has_nat_gateways_by_az ? 0 : local.availability_zone_count

  vpc = true

  tags = merge(local.tags, {
    Name = format("%s-%s",
      local.deployment_name,
      data.aws_availability_zones.available.names[count.index]
    )
  })
}
