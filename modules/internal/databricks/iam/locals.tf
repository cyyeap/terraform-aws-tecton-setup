module "deployment_name" {
  source          = "../../deployment_name"
  deployment_name = var.deployment_name
}

locals {
  deployment_name = module.deployment_name.deployment_name

  account_id             = data.aws_caller_identity.current.account_id
  databricks_account_id  = data.aws_caller_identity.databricks.id
  is_deployment_type_vpc = var.deployment_type == "vpc"
  region                 = data.aws_region.current.name
  spark_role_name        = data.aws_iam_role.spark_role.name
  templates_dir          = "${path.module}/../../templates"
  tags = merge(
    var.tags,
    { "tecton-accessible:${local.deployment_name}" : "true" }
  )
}
