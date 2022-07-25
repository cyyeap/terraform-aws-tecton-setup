output "deployment_name" {
  description = "The Tecton deployment name."
  value       = var.deployment_name
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = local.vpc_id
}

output "vpc_cidr_blocks" {
  description = "The CIDR blocks associated with the VPC."
  value       = local.vpc_cidr_blocks
}

output "nat_gateway_ips" {
  description = "The IDs of the NAT gateway public IPs."
  value       = module.tecton_network.nat_gateway_public_ips
}

output "private_subnet_route_table_ids" {
  description = "The IDs of the private subnet route tables."
  value       = local.private_subnet_route_table_ids
}

output "public_subnet_route_table_ids" {
  description = "The IDs of the public subnet route tables."
  value       = module.tecton_network.public_subnet_route_table_ids
}

output "dynamodb_vpc_endpoint_id" {
  description = "The DynamoDB VPC endpoint ID (if enabled)."
  value       = module.tecton_network.dynamodb_vpc_endpoint_id
}

output "s3_vpc_endpoint_id" {
  description = "The S3 VPC endpoint ID (if enabled)."
  value       = module.tecton_network.s3_vpc_endpoint_id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = local.private_subnet_ids
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = local.public_subnet_ids
}

output "security_group_ids" {
  description = "A map of the security group IDs."
  value       = local.security_group_ids
}

output "ingress_vpc_endpoint_security_group_id" {
  description = "If deployment_type is vpc, the ID of the ingress VPC endpoint."
  value       = module.tecton_security_groups.ingress_vpc_endpoint_id
}

output "roles" {
  description = "A mapping of the IAM roles."
  value       = local.roles
}

output "cross_account_role_arn" {
  description = "The ARN of the cross-account IAM role."
  value       = module.common.cross_account_role_arn
}

output "cross_account_role_name" {
  description = "The name of the cross-account IAM role."
  value       = module.common.cross_account_role_name
}

output "cross_account_external_id" {
  description = "The external ID to be associated with the cross-account assume role."
  value       = module.common.cross_account_external_id
}

output "eks_management_role_name" {
  description = "The name of the EKS management IAM role."
  value       = module.common.eks_management_role_name
}

output "eks_node_role_name" {
  description = "The name of the EKS node IAM role."
  value       = module.common.eks_node_role_name
}

output "spark_role_name" {
  description = "The name of the Spark IAM role."
  value       = module.common.spark_role_name
}

output "spark_role_arn" {
  description = "The ARN of the Spark IAM role."
  value       = module.iam.spark_role_arn
}

output "s3_bucket" {
  description = "The Tecton S3 bucket."
  value       = module.common.s3_bucket
}

output "region" {
  description = "The AWS region."
  value       = module.common.region
}

output "master_role_name" {
  description = "The name of the EMR master role."
  value       = module.iam.master_role_name
}

output "spark_instance_profile_arn" {
  description = "The ARN of the spark instance profile."
  value       = module.iam.spark_instance_profile_arn
}

output "spark_instance_profile_name" {
  description = "The name of the spark instance profile."
  value       = module.iam.spark_instance_profile_name
}
