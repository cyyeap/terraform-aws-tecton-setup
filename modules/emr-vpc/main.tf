locals {
  deployment_name = var.deployment_name
  deployment_type = "vpc"
  tags            = var.tags
  vpc_id          = module.tecton_network.vpc_id

  deployment_info = {
    deployment_name        = var.deployment_name
    deployment_type        = local.deployment_type
    account_id             = module.common.account_id
    region                 = module.common.region
    is_elasticache_enabled = var.enable_elasticache
    is_debugging_enabled   = var.enable_tecton_support_debugging_access
    s3_bucket_id           = module.common.s3_bucket.id

    network = {
      vpc_id                   = local.vpc_id
      availability_zone_count  = module.tecton_network.availability_zone_count
      dynamodb_vpc_endpoint_id = module.tecton_network.dynamodb_vpc_endpoint_id
      s3_vpc_endpoint_id       = module.tecton_network.s3_vpc_endpoint_id
      nat_gateway_public_ips   = module.tecton_network.nat_gateway_public_ips

      private_subnet_route_table_ids = {
        tecton = module.tecton_network.private_subnet_route_table_ids,
        emr    = module.emr_network.private_subnet_route_table_ids,
      }

      public_subnet_route_table_ids = {
        tecton = module.tecton_network.public_subnet_route_table_ids
      }

      subnet_ids = {
        tecton = module.tecton_network.private_subnet_ids
        emr    = module.emr_network.private_subnet_ids
        public = module.tecton_network.public_subnet_ids
      }

      vpc_cidr_blocks = {
        tecton = module.tecton_network.vpc_cidr_block
        emr    = module.emr_network.vpc_cidr_block
      }

      security_group_ids = {
        tecton = module.tecton_security_groups.ids,
        emr    = module.emr_security_groups.ids,
      }

      is_vpc_cidr_block_association_enabled = {
        tecton = var.enable_tecton_vpc_cidr_block_association
        emr    = var.enable_emr_vpc_cidr_block_association
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

    compute = {
      master_role_name            = module.iam.master_role_name
      spark_instance_profile_arn  = module.iam.spark_instance_profile_arn
      spark_instance_profile_name = module.iam.spark_instance_profile_name
      spark_role_arn              = module.iam.spark_role_arn
      spark_role_name             = module.iam.spark_role_name
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
  spark_role_name = module.iam.spark_role_name

  cross_account_assume_role_allowed_ids    = var.cross_account_assume_role_allowed_ids
  cross_account_external_id                = var.cross_account_external_id
  additional_s3_read_only_principals       = var.additional_s3_read_only_principals
  enable_spot_service_linked_role          = var.enable_spot_service_linked_role
  enable_eks_nodegroup_service_linked_role = var.enable_eks_nodegroup_service_linked_role
  enable_elasticache                       = var.enable_elasticache

  providers = {
    aws = aws
  }
}

module "iam" {
  source = "../internal/emr/iam"

  deployment_name   = local.deployment_name
  deployment_type   = local.deployment_type
  tags              = local.tags
  spark_access_role = module.common.eks_node_role_name

  spark_role_name = var.spark_role_name

  providers = {
    aws = aws
  }
}

module "tecton_network" {
  source = "../internal/network"

  deployment_name = local.deployment_name
  tags            = local.tags

  availability_zone_count           = var.availability_zone_count
  dynamodb_vpc_endpoint_id          = var.dynamodb_vpc_endpoint_id
  enable_dynamodb_vpc_endpoint      = var.enable_dynamodb_vpc_endpoint
  enable_s3_vpc_endpoint            = var.enable_s3_vpc_endpoint
  enable_vpc_cidr_block_association = var.enable_tecton_vpc_cidr_block_association
  nat_gateways_by_az                = var.nat_gateways_by_az
  s3_vpc_endpoint_id                = var.s3_vpc_endpoint_id
  vpc_cidr_block                    = var.tecton_vpc_cidr_block
  vpc_id                            = var.vpc_id

  providers = {
    aws = aws
  }
}

module "emr_network" {
  source = "../internal/network"

  deployment_name              = format("%s-emr", local.deployment_name)
  tags                         = local.tags
  vpc_id                       = local.vpc_id
  availability_zone_count      = module.tecton_network.availability_zone_count
  dynamodb_vpc_endpoint_id     = module.tecton_network.dynamodb_vpc_endpoint_id
  s3_vpc_endpoint_id           = module.tecton_network.s3_vpc_endpoint_id
  enable_dynamodb_vpc_endpoint = false
  enable_s3_vpc_endpoint       = false

  # reuse public subnets (+IG) from tecton_network
  nat_gateways_by_az    = module.tecton_network.nat_gateways_by_az
  enable_public_subnets = false

  vpc_cidr_block                    = var.emr_vpc_cidr_block
  enable_vpc_cidr_block_association = var.enable_emr_vpc_cidr_block_association

  providers = {
    aws = aws
  }
}

module "tecton_security_groups" {
  source = "../internal/vpc/security_groups"

  deployment_name = local.deployment_name
  tags            = local.tags
  vpc_id          = local.vpc_id
  nat_gateway_ips = module.tecton_network.nat_gateway_public_ips

  enable_cluster_vpc_endpoint  = var.enable_cluster_vpc_endpoint
  ingress_allowed_cidr_blocks  = var.ingress_allowed_cidr_blocks
  ingress_load_balancer_public = var.ingress_load_balancer_public

  providers = {
    aws = aws
  }
}

module "emr_security_groups" {
  source = "../internal/emr/security_groups"

  deployment_name = local.deployment_name
  vpc_id          = local.vpc_id
  tags            = local.tags

  cluster_security_group_id   = var.emr_cluster_security_group_id
  service_security_group_id   = var.emr_service_security_group_id
  enable_security_group_rules = var.enable_security_group_rules

  providers = {
    aws = aws
  }
}

module "debugging" {
  source = "../internal/emr/debugging"

  count = var.enable_tecton_support_debugging_access ? 1 : 0

  deployment_name         = local.deployment_name
  cross_account_role_name = var.debugging_cross_account_role_name

  providers = {
    aws = aws
  }
}
