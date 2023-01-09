terraform {
  required_version = ">= 0.13.5"
  required_providers {
    aws = {
      version = ">= 3"
      source  = "hashicorp/aws"
    }
    random = {
      version = ">= 3"
      source  = "hashicorp/random"
    }
  }
}

provider "aws" {
  alias = "databricks"
}
