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

variable "cross_account_external_id" {
  default     = null
  type        = string
  description = <<EOV
A string ID to be required when using the cross-account role. If none specified one will
be generated (recommended).
EOV
}

variable "cross_account_assume_role_allowed_ids" {
  type        = list(string)
  description = <<EOV
A list of AWS account IDs allowed to assume the cross-account role(s). This should be an
AWS account ID that is provided by your Tecton rep.
EOV
}

variable "additional_s3_read_only_principals" {
  type        = list(string)
  default     = []
  description = <<EOV
Additional AWS principals that should be given read-only access to the Tecton S3 bucket
via the bucket policy.
EOV
}

variable "spark_role_name" {
  type        = string
  description = "The name of the spark role to attach default policies to."
}

variable "enable_spot_service_linked_role" {
  type        = bool
  default     = true
  description = "Toggle enabling the spot service linked role."
}

variable "enable_eks_nodegroup_service_linked_role" {
  type        = bool
  default     = true
  description = "toggle enabling the EKS nodegroup service linked role. Only applicable when deployment_type is vpc."
}

variable "enable_elasticache" {
  type        = bool
  default     = false
  description = "Toggle enabling resources supporting the ElastiCache."
}

variable "enable_eks_ingress_vpc_endpoint" {
  default     = true
  description = "Toggle enabling resources supporting the EKS Ingress VPC Endpoint for in-VPC communication."
  type        = bool
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}
