output "deployment_name" {
  description = "The Tecton deployment name."
  value       = var.deployment_name
}

output "databricks_workspace" {
  description = "The Databricks workspace name."
  value       = var.databricks_workspace
}

output "region" {
  description = "The AWS region."
  value       = module.common.region
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
