locals {
  deployment_name = var.deployment_name
  deployment_type = "saas"
  tags            = var.tags

  roles = {
    cross_account_role_name = module.common.cross_account_role_name
    spark_role_name         = module.iam.spark_role_name
  }
}

module "common" {
  source = "../internal/common"

  deployment_name = local.deployment_name
  deployment_type = local.deployment_type
  tags            = local.tags
  spark_role_name = module.iam.spark_role_name

  cross_account_external_id             = var.cross_account_external_id
  cross_account_assume_role_allowed_ids = var.cross_account_assume_role_allowed_ids
  additional_s3_read_only_principals    = var.additional_s3_read_only_principals
  enable_spot_service_linked_role       = var.enable_spot_service_linked_role
  enable_elasticache                    = var.enable_elasticache

  providers = {
    aws = aws
  }
}

module "iam" {
  source = "../internal/emr/iam"

  deployment_name   = local.deployment_name
  deployment_type   = local.deployment_type
  tags              = local.tags
  spark_access_role = module.common.cross_account_role_name

  spark_role_name = var.spark_role_name

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
  source = "../internal/emr/security_groups"

  deployment_name = local.deployment_name
  tags            = local.tags
  vpc_id          = module.network.vpc_id # note: if var.vpc_id specified, network module will return said value

  cluster_security_group_id   = var.emr_cluster_security_group_id
  service_security_group_id   = var.emr_service_security_group_id
  enable_security_group_rules = var.enable_security_group_rules

  providers = {
    aws = aws
  }
}

module "debugging" {
  source = "../internal/emr/debugging"

  count = var.enable_tecton_support_debugging_access ? 1 : 0

  deployment_name = local.deployment_name

  cross_account_role_name = var.debugging_cross_account_role_name

  providers = {
    aws = aws
  }
}
