provider "aws" {
  region = "us-west-2"
}

module "tecton" {
  source = "../../modules/emr-vpc"

  deployment_name                       = "<DEPLOYMENT_NAME>"
  spark_role_name                       = "<SPARK_ROLE_NAME>"
  cross_account_assume_role_allowed_ids = ["<TECTON_ASSUMING_ACCOUNT_ID>"]

  providers = {
    aws = aws
  }
}

variable "enable_notebook_cluster" {
  default     = false
  description = <<EOV
* This can not be enabled until the Tecton cluster is fully provisioned on the Tecton side *
Toggle enabling the EMR notebook cluster. Default: false.
EOV
}

module "notebook_cluster" {
  source = "../../modules/emr-notebook-cluster"

  count = var.enable_notebook_cluster ? 1 : 0

  deployment_name           = "<DEPLOYMENT_NAME>"
  subnet_ids                = module.tecton.private_subnet_ids
  instance_profile_arn      = module.tecton.spark_instance_profile_arn
  service_role_id           = module.tecton.master_role_name
  cluster_security_group_id = module.tecton.security_group_ids.emr.cluster
  service_security_group_id = module.tecton.security_group_ids.emr.service

  // Optional
  enable_glue = true

  providers = {
    aws = aws
  }
}
