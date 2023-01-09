output "cross_account_role_arn" {
  description = "The ARN of the cross-account role."
  value       = aws_iam_role.cross_account_role.arn
}

output "cross_account_role_name" {
  description = "The name of the cross-account role."
  value       = aws_iam_role.cross_account_role.name
}

output "cross_account_external_id" {
  description = "The external-id required when assuming the cross-account role."
  value       = local.cross_account_external_id
}

output "eks_cluster_role_name" {
  description = "If deployment_type is vpc, the name of the EKS cluster role."
  value       = local.is_deployment_type_vpc ? aws_iam_role.eks_cluster_role[0].name : null
}

output "eks_node_role_name" {
  description = "If deployment_type is vpc, the name of the EKS cluster node role."
  value       = local.is_deployment_type_vpc ? aws_iam_role.eks_node_role[0].name : null
}

output "spark_role_name" {
  description = "The name of the spark role."
  value       = var.spark_role_name
}

output "s3_bucket" {
  description = "The Tecton S3 bucket."
  value       = aws_s3_bucket.tecton
}

output "region" {
  description = "The region which Tecton will be deployed to."
  value       = data.aws_region.current.name
}

output "roles" {
  description = "A mapping of the IAM roles."
  value       = local.roles
}

output "spot_service_linked_role_arn" {
  value = aws_iam_service_linked_role.spot[0].arn
}

output "eks_nodegroup_service_linked_role_arn" {
  value = local.is_deployment_type_vpc && var.enable_eks_nodegroup_service_linked_role ? aws_iam_service_linked_role.eks_nodegroup[0].arn : null
}

output "account_id" {
  value = local.account_id
}
