module "deployment_name" {
  source          = "../../deployment_name"
  deployment_name = var.deployment_name
}

locals {
  deployment_name = module.deployment_name.deployment_name

  has_cluster_security_group_id = var.cluster_security_group_id != null
  has_service_security_group_id = var.service_security_group_id != null
  cluster_security_group_id     = local.has_cluster_security_group_id ? var.cluster_security_group_id : aws_security_group.cluster_security_group[0].id
  service_security_group_id     = local.has_service_security_group_id ? var.service_security_group_id : aws_security_group.service_security_group[0].id
  tags = merge(
    var.tags,
    { "tecton-accessible:${local.deployment_name}" : "true" }
  )
}
