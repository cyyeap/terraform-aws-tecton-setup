variable "deployment_name" {
  type        = string
  description = "(Required) A unique deployment name."

  validation {
    condition     = length(trimprefix(var.deployment_name, "tecton-")) < 22
    error_message = "The variable deployment_name must be less than 22 characters, minus a prefix of 'tecton-' as it will be appended if not already."
  }
}
