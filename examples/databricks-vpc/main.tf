
// tecton account
provider "aws" {
  region = "us-west-2"
}

// databricks account
//  if databricks is deployed to the same account as tecton
//  this may be omitted
provider "aws" {
  region = "us-west-2"
  alias  = "databricks"
}

module "tecton" {
  source = "../../modules/databricks-vpc/"

  databricks_workspace                  = "<DATABRICKS_WORKSPACE>"
  deployment_name                       = "<DEPLOYMENT_NAME>"
  spark_role_name                       = "<SPARK_ROLE_NAME>"
  cross_account_assume_role_allowed_ids = ["<TECTON_ASSUMING_ACCOUNT_ID>"]

  providers = {
    aws = aws

    // if databricks is deployed to the same account as tecton
    //  use `aws.databricks = aws` rather than `aws.databricks = aws.databricks`
    aws.databricks = aws.databricks
  }
}
