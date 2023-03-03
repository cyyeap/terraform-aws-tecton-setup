
provider "aws" {
  region = "us-west-2"
}

module "privatelink_cross_vpc" {
  source                                    = "../../modules/privatelink-cross-vpc"
  vpc_id                                    = var.vpc_id
  vpc_endpoint_subnet_ids                   = var.vpc_endpoint_subnet_ids
  dns_name                                  = var.dns_name
  vpc_endpoint_service_name                 = var.vpc_endpoint_service_name
  vpc_endpoint_security_group_egress_cidrs  = var.vpc_endpoint_security_group_egress_cidrs
  vpc_endpoint_security_group_ingress_cidrs = var.vpc_endpoint_security_group_ingress_cidrs
  providers = {
    aws = aws
  }
}

variable "vpc_id" {
  description = "VPC ID from which to create the VPC endpoint"
  type        = string
}

variable "vpc_endpoint_subnet_ids" {
  description = "Private subnet ids where to create VPC endpiont"
  type        = list(string)
}
variable "dns_name" {
  description = "DNS name for Tecton servcies"
  type        = string
}

variable "vpc_endpoint_service_name" {
  description = "Name of the pre-existing VPC endpoint service to connect to"
  type        = string
}

variable "vpc_endpoint_security_group_ingress_cidrs" {
  description = "Ingress CIDR blocks of the VPC endpiont security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpc_endpoint_security_group_egress_cidrs" {
  description = "Egress CIDR blocks of the VPC endpiont security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

output "caller_identity" {
  description = "Current caller identity"
  value       = module.privatelink_cross_vpc.caller_identity
}

terraform {
  required_version = ">= 0.13.5"
  required_providers {
    aws = {
      version = "~> 3"
      source  = "hashicorp/aws"
    }
  }
}
