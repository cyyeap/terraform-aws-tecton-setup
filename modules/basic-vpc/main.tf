locals {
  deployment_name = var.deployment_name
  deployment_type = "vpc"
  vpc_id          = module.network.vpc_id
  roles           = module.common.roles
  tags            = var.tags
}

module "common" {
  source = "../internal/common"

  deployment_name = local.deployment_name
  deployment_type = local.deployment_type
  tags            = local.tags

  spark_role_name                          = var.spark_role_name
  cross_account_assume_role_allowed_ids    = var.cross_account_assume_role_allowed_ids
  cross_account_external_id                = var.cross_account_external_id
  enable_spot_service_linked_role          = var.enable_spot_service_linked_role
  enable_eks_nodegroup_service_linked_role = var.enable_eks_nodegroup_service_linked_role
  enable_elasticache                       = var.enable_elasticache

  providers = {
    aws = aws
  }
}

module "network" {
  source = "../internal/network"

  deployment_name = local.deployment_name
  tags            = local.tags

  availability_zone_count           = var.availability_zone_count
  dynamodb_vpc_endpoint_id          = var.dynamodb_vpc_endpoint_id
  enable_dynamodb_vpc_endpoint      = var.enable_dynamodb_vpc_endpoint
  enable_s3_vpc_endpoint            = var.enable_s3_vpc_endpoint
  enable_vpc_cidr_block_association = var.enable_vpc_cidr_block_association
  nat_gateways_by_az                = var.nat_gateways_by_az
  s3_vpc_endpoint_id                = var.s3_vpc_endpoint_id
  vpc_cidr_block                    = var.vpc_cidr_block
  vpc_id                            = var.vpc_id

  providers = {
    aws = aws
  }
}

module "security_groups" {
  source = "../internal/vpc/security_groups"

  deployment_name = local.deployment_name
  tags            = local.tags
  vpc_id          = local.vpc_id
  nat_gateway_ips = module.network.nat_gateway_public_ips

  enable_ingress_vpc_endpoint  = var.enable_ingress_vpc_endpoint
  ingress_allowed_cidr_blocks  = var.ingress_allowed_cidr_blocks
  ingress_load_balancer_public = var.ingress_load_balancer_public

  providers = {
    aws = aws
  }
}
