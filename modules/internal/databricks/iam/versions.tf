terraform {
  required_version = ">= 0.13.5"
  required_providers {
    aws = {
      version               = ">= 3"
      source                = "hashicorp/aws"
      configuration_aliases = [aws.tecton, aws.databricks]
    }
    random = {
      version = ">= 3"
      source  = "hashicorp/random"
    }
  }
}

/* ╭──────────────────────────────────────────────────────────╮
   │ provider blocks should be removed in favor of            │
   │  configuration_aliases (above) once                      │
   │  https://github.com/hashicorp/terraform/issues/28490     │
   │  is resolved                                             │
   ╰──────────────────────────────────────────────────────────╯

*/

# Tecton deployment account
provider "aws" {
  alias = "tecton"
}

# Databricks deployment account
#  may be the same or different from Tecton above
provider "aws" {
  alias = "databricks"
}
