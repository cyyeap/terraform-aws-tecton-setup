locals {
  deployment_name = var.deployment_name
  deployment_type = "vpc"
  tags            = var.tags
  vpc_id          = module.network.vpc_id

  deployment_info = {
    deployment_name        = var.deployment_name
    deployment_type        = local.deployment_type
    account_id             = module.common.account_id
    region                 = module.common.region
    is_elasticache_enabled = var.enable_elasticache
    s3_bucket_id           = module.common.s3_bucket.id

    network = {
      vpc_id                   = local.vpc_id
      availability_zone_count  = module.network.availability_zone_count
      dynamodb_vpc_endpoint_id = module.network.dynamodb_vpc_endpoint_id
      s3_vpc_endpoint_id       = module.network.s3_vpc_endpoint_id
      nat_gateway_public_ips   = module.network.nat_gateway_public_ips

      private_subnet_route_table_ids = {
        tecton = module.network.private_subnet_route_table_ids,
      }

      public_subnet_route_table_ids = {
        tecton = module.network.public_subnet_route_table_ids
      }

      subnet_ids = {
        tecton = module.network.private_subnet_ids
        public = module.network.public_subnet_ids
      }

      vpc_cidr_blocks = {
        tecton = module.network.vpc_cidr_block
      }

      security_group_ids = {
        tecton = module.security_groups.ids
      }

      is_vpc_cidr_block_association_enabled = {
        tecton = var.enable_vpc_cidr_block_association
      }
    }

    iam = {
      cross_account_role_arn                = module.common.cross_account_role_arn
      cross_account_role_name               = module.common.cross_account_role_name
      cross_account_external_id             = module.common.cross_account_external_id
      eks_cluster_role_name                 = module.common.eks_cluster_role_name
      eks_node_role_name                    = module.common.eks_node_role_name
      spot_service_linked_role_arn          = module.common.spot_service_linked_role_arn
      eks_nodegroup_service_linked_role_arn = module.common.eks_nodegroup_service_linked_role_arn
    }

    tags = local.tags
  }
}

module "common" {
  source = "../internal/common"

  deployment_name = local.deployment_name
  deployment_type = local.deployment_type
  deployment_info = local.deployment_info
  tags            = local.tags

  spark_role_name                          = var.spark_role_name
  cross_account_assume_role_allowed_ids    = var.cross_account_assume_role_allowed_ids
  cross_account_external_id                = var.cross_account_external_id
  enable_spot_service_linked_role          = var.enable_spot_service_linked_role
  enable_eks_nodegroup_service_linked_role = var.enable_eks_nodegroup_service_linked_role
  enable_elasticache                       = var.enable_elasticache

  providers = {
    aws = aws
  }
}

module "network" {
  source = "../internal/network"

  deployment_name = local.deployment_name
  tags            = local.tags

  availability_zone_count           = var.availability_zone_count
  dynamodb_vpc_endpoint_id          = var.dynamodb_vpc_endpoint_id
  enable_dynamodb_vpc_endpoint      = var.enable_dynamodb_vpc_endpoint
  enable_s3_vpc_endpoint            = var.enable_s3_vpc_endpoint
  enable_vpc_cidr_block_association = var.enable_vpc_cidr_block_association
  nat_gateways_by_az                = var.nat_gateways_by_az
  s3_vpc_endpoint_id                = var.s3_vpc_endpoint_id
  vpc_cidr_block                    = var.vpc_cidr_block
  vpc_id                            = var.vpc_id

  providers = {
    aws = aws
  }
}

module "security_groups" {
  source = "../internal/vpc/security_groups"

  deployment_name = local.deployment_name
  tags            = local.tags
  vpc_id          = local.vpc_id
  nat_gateway_ips = module.network.nat_gateway_public_ips

  enable_cluster_vpc_endpoint  = var.enable_cluster_vpc_endpoint
  ingress_allowed_cidr_blocks  = var.ingress_allowed_cidr_blocks
  ingress_load_balancer_public = var.ingress_load_balancer_public

  providers = {
    aws = aws
  }
}
