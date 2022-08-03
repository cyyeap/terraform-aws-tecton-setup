locals {
  deployment_name = var.deployment_name
  deployment_type = "saas"
  tags            = var.tags
}

module "common" {
  source = "../internal/common"

  deployment_type = local.deployment_type
  deployment_name = local.deployment_name
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
