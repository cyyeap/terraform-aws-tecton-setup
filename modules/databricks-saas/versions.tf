terraform {
  required_version = ">= 0.13.5"
  required_providers {
    aws = {
      version = ">= 3"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {}

provider "aws" {
  alias = "databricks"
}

# https://github.com/terraform-docs/terraform-docs/issues/371
# tflint-ignore: terraform_unused_declarations
data "aws_caller_identity" "this" {
  count = 0
}
