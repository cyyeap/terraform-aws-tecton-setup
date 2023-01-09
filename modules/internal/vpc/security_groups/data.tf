data "aws_vpc" "vpc" {
  count = local.has_ingress_allowed_cidr_blocks ? 1 : 0

  id = var.vpc_id
}
