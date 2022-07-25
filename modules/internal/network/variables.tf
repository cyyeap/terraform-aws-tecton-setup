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
  description = <<EOV
The CIDR block for the private and public subnets for this module to create. The
smallest acceptable prefix is /18. Only half of the CIDR will be used to reserve space for future
growth.
EOV
  validation {
    condition     = tonumber(regex("/([0-9]+)", var.vpc_cidr_block)[0]) <= 18
    error_message = "Subnet must have enough space: the smallest acceptable prefix is /18."
  }
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

variable "enable_public_subnets" {
  type        = bool
  default     = true
  description = "Toggle enabling the creation of the public subnets."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
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
