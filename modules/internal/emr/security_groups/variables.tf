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

variable "availability_zone_count" {
  type        = number
  default     = 2
  description = "The number of availability zones for Tecton to use EMR in. Default: 2."
}

variable "cluster_security_group_id" {
  type        = string
  default     = null
  description = <<EOV
  Optionally provide a security group to place EMR cluster resources in. It is
recommended to use the defaults (module will create the security group).
EOV
}

variable "service_security_group_id" {
  type        = string
  default     = null
  description = <<EOV
Optionally provide a security group to place EMR service resources in. It is
recommended to use the defaults (module will create the security group).
EOV
}

variable "enable_security_group_rules" {
  type        = bool
  default     = true
  description = <<EOV
Disable the creation of security group rules. It is recommended
to use the defaults (module will create the security group rules associated
with the appropriate security group).
EOV
}

variable "vpc_id" {
  default     = null
  type        = string
  description = <<EOV
The ID of a pre-existing VPC to deploy the networking resources to.
By default (recommended) one will be created if none specified.
EOV
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}
