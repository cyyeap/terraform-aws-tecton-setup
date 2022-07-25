
output "master_role_name" {
  description = "The EMR Master role name."
  value       = aws_iam_role.master_role.name
}

output "spark_instance_profile_arn" {
  description = "The spark instance profile ARN."
  value       = aws_iam_instance_profile.spark.arn
}

output "spark_instance_profile_name" {
  description = "The spark instance profile name."
  value       = aws_iam_instance_profile.spark.name
}

output "spark_role_name" {
  description = "The spark role name."
  value       = aws_iam_role.spark_role.name
}

output "spark_role_arn" {
  description = "The spark role arn."
  value       = aws_iam_role.spark_role.arn
}
