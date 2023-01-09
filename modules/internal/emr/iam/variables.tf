variable "deployment_name" {
  type        = string
  description = "A unique deployment name."

  validation {
    condition     = length(trimprefix(var.deployment_name, "tecton-")) < 22
    error_message = "The variable deployment_name must be less than 22 characters, minus a prefix of 'tecton-' as it will be appended if not already."
  }
}

variable "deployment_type" {
  type        = string
  description = "The type of Tecton cluster deployment. (to be provided by Tecton rep)"
  validation {
    condition     = contains(["saas", "vpc"], var.deployment_type)
    error_message = "The variable deployment_type should be one of: saas, vpc."
  }
}

variable "spark_access_role" {
  type        = string
  description = <<EOV
The name of the role which the spark access policy should be attached to. Typically this
is the Tecton cluster node role.
EOV
}

variable "spark_role_name" {
  default     = null
  type        = string
  description = "Override the default name for emr spark role. * not recommended *"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}
