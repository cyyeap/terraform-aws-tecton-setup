output "availability_zone_count" {
  description = "The number of availability zones in-use."
  value       = local.availability_zone_count
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = local.vpc_id
}

output "nat_gateways_by_az" {
  description = "A map of nat gateways by their respective availability zone. (`{availability_zone_name: nat_gateway_id}`)"
  value = zipmap(
    slice(data.aws_availability_zones.available.names, 0, local.availability_zone_count),
    aws_nat_gateway.vpc[*].id
  )
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "nat_gateway_public_ips" {
  description = "The IDs of the NAT gateway public IPs."
  value       = aws_eip.nat[*].public_ip
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_route_table_ids" {
  description = "The IDs of the private subnet route tables."
  value       = aws_route_table.private[*].id
}

output "public_subnet_route_table_ids" {
  description = "The IDs of the public subnet route tables."
  value       = aws_route_table.public[*].id
}

output "vpc_cidr_block" {
  description = "The VPC CIDR block."
  value       = var.vpc_cidr_block
}

output "dynamodb_vpc_endpoint_id" {
  description = "The DynamoDB VPC endpoint ID (if enabled)."
  value       = local.dynamodb_vpc_endpoint_id
}

output "s3_vpc_endpoint_id" {
  description = "The S3 VPC endpoint ID (if enabled)."
  value       = local.s3_vpc_endpoint_id
}
