resource "aws_vpc" "tecton" {
  count = local.has_vpc_id ? 0 : 1

  cidr_block = var.vpc_cidr_block
  tags = {
    Name = local.deployment_name
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "vpc_cidr_block" {
  count = local.has_vpc_id && var.enable_vpc_cidr_block_association ? 1 : 0

  vpc_id     = local.vpc_id
  cidr_block = var.vpc_cidr_block
}
