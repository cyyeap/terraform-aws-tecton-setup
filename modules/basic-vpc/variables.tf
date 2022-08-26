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
    error_message = "The variable deployment_name must be less than 22 characters, minus a prefix of 'tecton-' as it will be appended if not already."
  }
}

variable "spark_role_name" {
  type        = string
  description = "The name of the spark role used to attach policies to."
}

variable "enable_spot_service_linked_role" {
  type        = bool
  default     = true
  description = "Toggle enabling the spot service linked role."
}

variable "enable_eks_nodegroup_service_linked_role" {
  type        = bool
  default     = true
  description = "Toggle enabling the spot service linked role."
}

variable "availability_zone_count" {
  default     = 0
  type        = number
  description = <<EOV
The number of availability zones to deploy in to. If none specified (default), 3 will be
used, unless region only has 2 available AZs. Please set this to 3 unless the region being deployed
to only has 2 AZs.
EOV
}

variable "vpc_id" {
  default     = null
  type        = string
  description = <<EOV
The ID of a pre-existing VPC to deploy the networking resources to. By default
(recommended) one will be created if none specified.
EOV
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.64.0.0/16"
  description = <<EOV
  The VPC cidr block for the private and public subnets which will be created.
`vpc_cidr_block` will be associated with the created (or specified) VPC. The smallest acceptable
prefix is /18.
EOV

  validation {
    condition     = tonumber(regex("/([0-9]+)", var.vpc_cidr_block)[0]) <= 18
    error_message = "Subnet must have enough space: the smallest acceptable prefix is /18."
  }
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}

variable "enable_vpc_cidr_block_association" {
  type        = bool
  default     = true
  description = <<EOV
Only used when `vpc_id` is specified. Toggle enabling the
`aws_vpc_ipv4_cidr_block_association` between the given `vpc_cidr_block` and the VPC specified by
`vpc_id`. Should only be disabled if the VPC specified VPC cidr exists and is already associated
with the specified VPC.
EOV
}

variable "dynamodb_vpc_endpoint_id" {
  type        = string
  default     = null
  description = <<EOV
Specify the DynamoDB VPC endpoint to route traffic to. If not specified and
`enable_dynamodb_vpc_endpoint` is true one will be created.
EOV
}

variable "enable_dynamodb_vpc_endpoint" {
  type        = bool
  default     = true
  description = "Toggle enabling the creation of the DynamoDB VPC endpoint."
}

variable "s3_vpc_endpoint_id" {
  type        = string
  default     = null
  description = <<EOV
Specify the S3 VPC endpoint to route traffic to. If not specified and
`enable_s3_vpc_endpoint` is true one will be created.
EOV
}

variable "enable_s3_vpc_endpoint" {
  type        = bool
  default     = true
  description = "Toggle enabling the creation of the s3 VPC endpoint."
}

variable "nat_gateways_by_az" {
  type        = map(string)
  default     = null
  description = <<EOF
Specify existing NAT gateways to be routed to. Input as a mapping of
`availability_zone : nat_gateway_id` (example:
`{"us-west-2a"= "nat_gateway_a","us-west-2b"= "nat_gateway_b","us-west-2c"= "nat_gateway_c"}`).
If none specified, one NAT gateway will be created per availability zone."
EOF
}

variable "enable_elasticache" {
  type        = bool
  default     = false
  description = "Toggle enabling resources supporting the ElastiCache."
}
