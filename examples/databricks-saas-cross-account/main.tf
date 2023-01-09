/*
This example assumes Tecton and Databricks are in different accounts
    if databricks is deployed to the same account as tecton please
    refer to the databricks-saas example
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
  source = "../../modules/databricks-saas/"

  deployment_name                       = var.deployment_name
  databricks_workspace                  = var.databricks_workspace
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

variable "databricks_workspace" {
  type        = string
  description = <<EOD
The Databricks workspace name not including the full url and not including `cloud.databricks.com`.
For example: `my-workspace.cloud.databricks.com` -> `my-workspace`.
EOD
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

terraform {
  required_version = ">= 0.13.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3"
    }
  }
}
