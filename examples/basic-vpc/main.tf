// tecton account
provider "aws" {
  region = "us-west-2"
}

module "tecton" {
  source = "../../modules/basic-vpc/"

  deployment_name                       = var.deployment_name
  spark_role_name                       = var.spark_role_name
  cross_account_assume_role_allowed_ids = var.cross_account_assume_role_allowed_ids

  providers = {
    aws = aws
  }
}

variable "deployment_name" {
  description = "A unique deployment name."
  type        = string
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
