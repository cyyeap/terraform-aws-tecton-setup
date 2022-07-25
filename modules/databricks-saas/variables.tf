variable "cross_account_external_id" {
  default     = null
  type        = string
  description = <<EOV
A random ID to be associated with the cross-account assume role. This will need to be
communicated to your Tecton technical support rep. By default a random ID will be generated if none
provided.
EOV
}

variable "cross_account_assume_role_allowed_ids" {
  type        = list(string)
  description = <<EOV
A list of AWS account IDs allowed to assume the cross-account role(s). This should be an
AWS account ID that is provided by your Tecton rep.
EOV
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

variable "databricks_workspace" {
  type        = string
  description = <<EOD
The Databricks workspace name not including the full url and not including `cloud.databricks.com`.
E.g. `my-workspace.cloud.databricks.com` -> `my-workspace`.
EOD

  validation {
    condition = (
      length(split("https://", var.databricks_workspace)) == 1
      ) && (
      length(split("cloud.databricks.com", var.databricks_workspace)) == 1
    )
    error_message = <<EOM
The databricks workspace should only be the workspace name, not including the full url and not
including `cloud.databricks.com`. E.g. `my-workspace.cloud.databricks.com` -> `my-workspace`.
EOM
  }
}

variable "spark_role_name" {
  type        = string
  description = "The name of the spark role used for Databricks to attach policies to."
}

variable "enable_spot_service_linked_role" {
  type        = bool
  default     = true
  description = "toggle enabling the spot service linked role."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}

variable "enable_elasticache" {
  type        = bool
  default     = false
  description = "Toggle enabling resources supporting the ElastiCache."
}
