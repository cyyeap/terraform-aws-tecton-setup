terraform {
  required_version = ">= 0.13.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  alias = "databricks"
}
