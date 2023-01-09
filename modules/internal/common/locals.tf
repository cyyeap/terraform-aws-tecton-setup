module "deployment_name" {
  source          = "../deployment_name"
  deployment_name = var.deployment_name
}

locals {
  deployment_name = module.deployment_name.deployment_name

  account_id             = data.aws_caller_identity.current.account_id
  is_deployment_type_vpc = var.deployment_type == "vpc"
  region                 = data.aws_region.current.name
  templates_dir          = "${path.module}/../templates"

  has_cross_account_external_id = var.cross_account_external_id != null
  cross_account_external_id     = local.has_cross_account_external_id ? var.cross_account_external_id : random_id.external_id[0].id

  tags = merge(var.tags,
    {
      "tecton-accessible:${local.deployment_name}" = "true",
    }
  )

  roles = merge(
    { cross_account_role_name = aws_iam_role.cross_account_role.name },
    local.roles_vpc,
  )
  roles_vpc = local.is_deployment_type_vpc ? {
    eks_cluster_role_name = aws_iam_role.eks_cluster_role[0].name
    eks_node_role_name    = aws_iam_role.eks_node_role[0].name
  } : {}
}
