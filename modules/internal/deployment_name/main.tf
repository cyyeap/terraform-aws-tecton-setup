locals {
  deployment_name_starts_with_tecton = trimprefix(var.deployment_name, "tecton-") != var.deployment_name
  deployment_name                    = local.deployment_name_starts_with_tecton ? var.deployment_name : format("tecton-%s", var.deployment_name)
}
