provider "aws" {
  region = var.region
}

module "tecton" {
  source = "../../modules/emr-saas"

  deployment_name                       = var.deployment_name
  cross_account_assume_role_allowed_ids = var.cross_account_assume_role_allowed_ids

  providers = {
    aws = aws
  }
}

module "emr_notebook_cluster" {
  source = "../../modules/emr-notebook-cluster"

  count = var.enable_notebook_cluster ? 1 : 0

  deployment_name           = var.deployment_name
  subnet_ids                = module.tecton.private_subnet_ids
  instance_profile_arn      = module.tecton.spark_instance_profile_arn
  service_role_id           = module.tecton.master_role_name
  cluster_security_group_id = module.tecton.security_group_ids.cluster
  service_security_group_id = module.tecton.security_group_ids.service

  // Optional
  enable_glue     = var.enable_glue_on_notebook_cluster
  glue_account_id = var.notebook_cluster_glue_account_id

  providers = {
    aws = aws
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

variable "enable_notebook_cluster" {
  default     = false
  type        = bool
  description = <<EOV
* This can not be enabled until the Tecton cluster is fully provisioned on the Tecton side *
Toggle enabling the EMR notebook cluster. Default: false.
EOV
}

variable "enable_glue_on_notebook_cluster" {
  default     = false
  type        = bool
  description = <<EOV
If AWS Glue Catalog is set up and should be used to load Hive tables. Requires that
`glue_account_id` be set in addition.
EOV
}

variable "notebook_cluster_glue_account_id" {
  default     = null
  type        = string
  description = <<EOV
The ID of the AWS account containing the AWS Glue Catalog for cross-account access.
If `enable_glue` is set to true and this is not provided, the AWS account used to provision this
module will be used.
EOV
}

variable "cross_account_assume_role_allowed_ids" {
  type        = list(string)
  description = <<EOV
A list of AWS account IDs allowed to assume the cross-account role(s). This should be an
AWS account ID that is provided by your Tecton rep.
EOV
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
