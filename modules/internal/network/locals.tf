module "deployment_name" {
  source          = "../deployment_name"
  deployment_name = var.deployment_name
}

locals {
  deployment_name = module.deployment_name.deployment_name

  has_vpc_id                  = var.vpc_id != null
  vpc_id                      = local.has_vpc_id ? var.vpc_id : aws_vpc.tecton[0].id
  region                      = data.aws_region.current.name
  has_nat_gateways_by_az      = var.nat_gateways_by_az != null
  has_availability_zone_count = var.availability_zone_count > 0
  availability_zone_count = local.has_nat_gateways_by_az ? length(var.nat_gateways_by_az) : (
    local.has_availability_zone_count ? var.availability_zone_count : (
      length(data.aws_availability_zones.available) < 3 ? length(data.aws_availability_zones.available) : 3
    )
  )

  private_cidr_block = cidrsubnet(var.vpc_cidr_block, 2, 0)
  public_cidr_block  = cidrsubnet(var.vpc_cidr_block, 2, 3)

  has_dynamodb_vpc_endpoint_id = var.dynamodb_vpc_endpoint_id != null
  dynamodb_vpc_endpoint_id = var.enable_dynamodb_vpc_endpoint ? (
    local.has_dynamodb_vpc_endpoint_id ? var.dynamodb_vpc_endpoint_id : aws_vpc_endpoint.dynamodb[0].id
  ) : null
  has_s3_vpc_endpoint_id = var.s3_vpc_endpoint_id != null
  s3_vpc_endpoint_id = var.enable_s3_vpc_endpoint ? (
    local.has_s3_vpc_endpoint_id ? var.s3_vpc_endpoint_id : aws_vpc_endpoint.s3[0].id
  ) : null

  tags = merge(var.tags,
    {
      "tecton-accessible:${local.deployment_name}" = "true",
    }
  )
}
