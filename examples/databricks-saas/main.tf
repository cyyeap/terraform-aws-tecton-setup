provider "aws" {
  region = "us-west-2"
}

// This example assumes Tecton and Databricks are in the same account
//    if databricks is NOT deployed to the same account as tecton
//    add this additional provider and map it in the module below
// provider "aws" {
//   region = "us-west-2"
//   alias  = "databricks"
// }

module "tecton" {
  source = "../../modules/databricks-saas/"

  deployment_name                       = "<DEPLOYMENT_NAME>"
  databricks_workspace                  = "<DATABRICKS_WORKSPACE>"
  spark_role_name                       = "<SPARK_ROLE_NAME>"
  cross_account_assume_role_allowed_ids = ["<TECTON_ASSUMING_ACCOUNT_ID>"]

  providers = {
    aws            = aws
    aws.databricks = aws // if databricks is NOT deployed to the same account as tecton change the provider used
  }
}
