variable "deployment_name" {
  type        = string
  description = "A unique deployment name."

  validation {
    condition     = length(trimprefix(var.deployment_name, "tecton-")) < 22
    error_message = "The variable deployment_name must be less than 22 characters, minus a prefix of 'tecton-' as it will be appended if not already."
  }
}

variable "deployment_type" {
  description = "The type of Tecton cluster deployment. (to be provided by Tecton rep)"
  type        = string
  validation {
    condition     = contains(["saas", "vpc"], var.deployment_type)
    error_message = "The variable deployment_type should be one of: saas, vpc."
  }
}

variable "s3_bucket_arns" {
  description = <<EOV
ARNs of the S3 buckets which Spark should have access to. Should include the Tecton deployment
bucket. Defaults to just the deployment bucket (`tecton-${var.deployment_name}`) if not specified.
EOV
  default     = null
  type        = list(string)
}

variable "spark_role_name" {
  type        = string
  description = "The name of the spark role used for Databricks to attach policies to."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}

variable "tecton_cross_account_role_trusted_arns" {
  description = <<EOV
ARNs which should be allowed to assume the cross-account role if Databricks lives in a separate
account from the Tecton deployment. Defaults to the aws.databricks provider account.
EOV
  default     = []
  type        = list(string)
}
