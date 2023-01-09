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

variable "spark_role_name" {
  type        = string
  description = "The name of the spark role used for Databricks to attach policies to."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}
