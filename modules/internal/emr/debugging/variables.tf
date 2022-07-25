variable "deployment_name" {
  description = "A unique deployment name."
  type        = string
}

variable "cross_account_role_name" {
  type        = string
  description = "The name of the IAM role used for cross-account access. Used for debugging purposes."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}
