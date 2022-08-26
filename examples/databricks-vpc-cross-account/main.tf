/*
This example assumes Tecton and Databricks are in different accounts
    if databricks is deployed to the same account as tecton please
    refer to the databricks-vpc example
*/

# Tecton
provider "aws" {
  region = "us-west-2"
}

# Databricks
provider "aws" {
  region = "us-west-2"
  alias  = "databricks"
}

module "tecton" {
  source = "../../modules/databricks-vpc/"

  deployment_name                       = var.deployment_name
  databricks_workspace                  = var.databricks_workspace
  databricks_instance_profile_arn       = var.databricks_instance_profile_arn
  spark_role_name                       = var.spark_role_name
  cross_account_assume_role_allowed_ids = var.cross_account_assume_role_allowed_ids

  providers = {
    aws            = aws
    aws.databricks = aws.databricks
  }
}

variable "deployment_name" {
  description = "A unique deployment name."
  type        = string
}

variable "region" {
  description = "The AWS region to deploy into."
  default     = "us-west-2"
  type        = string
}

variable "databricks_workspace" {
  type        = string
  description = <<EOD
The Databricks workspace name not including the full url and not including `cloud.databricks.com`.
For example: `my-workspace.cloud.databricks.com` -> `my-workspace`.
EOD
}

variable "databricks_instance_profile_arn" {
  type        = string
  description = "The instance profile arn associated with the Databricks nodes in the Databricks workspace."
}

variable "spark_role_name" {
  description = "The name of an existing spark role to attach policies to."
  type        = string
}

variable "cross_account_assume_role_allowed_ids" {
  description = <<EOV
A list of AWS account IDs allowed to assume the cross-account role(s). This should be an
AWS account ID that is provided by your Tecton rep.
EOV
  type        = list(string)
}
