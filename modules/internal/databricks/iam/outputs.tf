output "spark_role_arn" {
  description = "The ARN of the spark role."
  value       = data.aws_iam_role.spark_role.arn
}

output "spark_role_name" {
  description = "The name of the spark role."
  value       = local.spark_role_name
}

output "cross_account_databricks_tecton_access_role_arn" {
  description = "The ARN of the AWS IAM role used to grant Databricks access to Tecton resources."
  value       = local.is_deployment_type_vpc ? aws_iam_role.cross_account_databricks_tecton_access[0].arn : null
}

output "cross_account_databricks_tecton_access_role_name" {
  description = "The name of the AWS IAM role used to grant Databricks access to Tecton resources."
  value       = local.is_deployment_type_vpc ? aws_iam_role.cross_account_databricks_tecton_access[0].name : null
}

output "cross_account_databricks_tecton_access_role_external_id" {
  description = "The external-id required when assuming the AWS IAM role used to grant Databricks access to Tecton resources."
  value       = local.is_deployment_type_vpc ? random_id.external_id[0].id : null
}
