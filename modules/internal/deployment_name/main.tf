locals {
  deployment_name_starts_with_tecton = trimprefix(var.deployment_name, "tecton-") != var.deployment_name
  deployment_name                    = local.deployment_name_starts_with_tecton ? var.deployment_name : format("tecton-%s", var.deployment_name)

}

variable "deployment_name" {
  type        = string
  description = "A unique deployment name."

  validation {
    condition     = length(trimprefix(var.deployment_name, "tecton-")) < 22
    error_message = <<EOM
The deployment_name must be less than 22 characters (minus a prefix of 'tecton-' as it will be
appended if not already)
EOM
  }
}

output "deployment_name" {
  value = local.deployment_name
}
