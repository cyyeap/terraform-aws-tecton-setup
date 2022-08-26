variable "deployment_name" {
  type        = string
  description = "A unique deployment name."

  validation {
    condition     = length(trimprefix(var.deployment_name, "tecton-")) < 22
    error_message = "The variable deployment_name must be less than 22 characters, minus a prefix of 'tecton-' as it will be appended if not already."
  }
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Additional tags to apply to resources."
}

variable "vpc_id" {
  default     = null
  type        = string
  description = <<EOV
The ID of a pre-existing VPC to deploy the networking resources to. By default
(recommended) one will be created if none specified.
EOV
}

variable "enable_cluster_vpc_endpoint" {
  type        = bool
  default     = true
  description = <<EOV
Toggle enabling resources supporting the Tecton cluster ingress VPC endpoint for in-VPC
communication. Should always be enabled when Tecton cluster is not publicly available.
EOV
}

variable "ingress_allowed_cidr_blocks" {
  default     = []
  type        = list(string)
  description = <<EOV
CIDR blocks that should be able to access the Tecton cluster. Defaults to `0.0.0.0/0` if
none specified.
EOV
}

variable "ingress_load_balancer_public" {
  default     = true
  type        = bool
  description = <<EOV
Toggle whether or not the Tecton cluster ingress should be accessible by the public
internet and have a public IP address.
EOV
}

variable "nat_gateway_ips" {
  default     = null
  type        = list(string)
  description = <<EOV
Public IP addresses of the NAT gateways from the public subnet. Must be set if
`allowed_CIDR_blocks` is `true` and `eks_ingress_load_balancer_public` is `true`.
EOV
}
