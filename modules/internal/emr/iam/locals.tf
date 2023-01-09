module "deployment_name" {
  source          = "../../deployment_name"
  deployment_name = var.deployment_name
}

locals {
  deployment_name = module.deployment_name.deployment_name

  account_id             = data.aws_caller_identity.current.account_id
  is_deployment_type_vpc = var.deployment_type == "vpc"
  region                 = data.aws_region.current.name
  spark_role_name        = var.spark_role_name != null ? var.spark_role_name : "${local.deployment_name}-emr-spark-role"
  templates_dir          = "${path.module}/../../templates"
  tags = merge(
    var.tags,
    { "tecton-accessible:${local.deployment_name}" : "true" }
  )
}
