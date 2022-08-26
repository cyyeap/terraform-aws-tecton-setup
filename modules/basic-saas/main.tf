locals {
  deployment_name = var.deployment_name
  deployment_type = "saas"
  tags            = var.tags

  deployment_info = {
    deployment_name        = var.deployment_name
    deployment_type        = local.deployment_type
    account_id             = module.common.account_id
    region                 = module.common.region
    is_elasticache_enabled = var.enable_elasticache
    s3_bucket_id           = module.common.s3_bucket.id

    iam = {
      cross_account_role_arn       = module.common.cross_account_role_arn
      cross_account_role_name      = module.common.cross_account_role_name
      cross_account_external_id    = module.common.cross_account_external_id
      spot_service_linked_role_arn = module.common.spot_service_linked_role_arn
    }

    tags = local.tags
  }
}

module "common" {
  source = "../internal/common"

  deployment_type = local.deployment_type
  deployment_name = local.deployment_name
  deployment_info = local.deployment_info
  tags            = local.tags
  spark_role_name = var.spark_role_name

  cross_account_assume_role_allowed_ids = var.cross_account_assume_role_allowed_ids
  cross_account_external_id             = var.cross_account_external_id
  enable_spot_service_linked_role       = var.enable_spot_service_linked_role
  enable_elasticache                    = var.enable_elasticache

  providers = {
    aws = aws
  }
}
