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

variable "cross_account_assume_role_allowed_ids" {
  type        = list(string)
  description = <<EOV
A list of AWS account IDs allowed to assume the cross-account role(s). This should be an
AWS account ID that is provided by your Tecton rep.
EOV
}

variable "spark_role_name" {
  type        = string
  default     = null
  description = "Override the default name for emr spark role. * not recommended *"
}

variable "additional_s3_read_only_principals" {
  type        = list(string)
  default     = []
  description = <<EOV
Additional AWS principals that should be given read-only access to the Tecton S3 bucket
via the bucket policy.
EOV
}

variable "debugging_cross_account_role_name" {
  default     = null
  type        = string
  description = <<EOV
When `enable_debugging` is true, the IAM role name to allow Tecton technical support
cross-account access to debug your notebook code
EOV
}

variable "enable_tecton_support_debugging_access" {
  default     = false
  type        = bool
  description = <<EOV
Enable resources (IAM) to allow your Tecton technical support reps to open and execute
EMR notebooks in your account to help troubleshoot or test code you are developing.
Requires `debugging_cross_account_role_name` to be set as well.
EOV
}

variable "cross_account_external_id" {
  default     = null
  type        = string
  description = <<EOV
A random ID to be associated with the cross-account assume role. This will need to be
communicated to your Tecton technical support rep. By default a random ID will be generated if none
provided.
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

variable "availability_zone_count" {
  default     = 0
  type        = number
  description = <<EOV
The number of availability zones to deploy in to. If none specified (default), 3 will be
used, unless region only has 2 available AZs. Please set this to 3 unless the region being deployed
to only has 2 AZs.
EOV
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.38.0.0/16"
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

variable "emr_cluster_security_group_id" {
  type        = string
  default     = null
  description = <<EOV
Optionally provide a security group to place EMR cluster resources in. It is
recommended to use the defaults (module will create the security group).
EOV
}

variable "emr_service_security_group_id" {
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}

variable "enable_spot_service_linked_role" {
  type        = bool
  default     = true
  description = "toggle enabling the EKS nodegroup service linked role. Only applicable when deployment_type is vpc."
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
