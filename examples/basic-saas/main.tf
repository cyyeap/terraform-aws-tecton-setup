provider "aws" {
  region = "us-west-2"
}

module "tecton" {
  source = "../../modules/basic-saas/"

  deployment_name                       = "<DEPLOYMENT_NAME>"
  spark_role_name                       = "<SPARK_ROLE_NAME>"
  cross_account_assume_role_allowed_ids = ["<TECTON_ASSUMING_ACCOUNT_ID>"]

  providers = {
    aws = aws
  }
}
