resource "aws_iam_policy" "cross_account_1" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name = "${local.deployment_name}-ca-1"
  policy = templatefile("${path.module}/../templates/vpc_cross_account_policy_1.json", {
    ACCOUNT_ID             = local.account_id
    DEPLOYMENT_NAME        = local.deployment_name
    DEPLOYMENT_NAME_CONCAT = format("%.24s", local.deployment_name)
    REGION                 = local.region
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cross_account_1" {
  count = local.is_deployment_type_vpc ? 1 : 0

  policy_arn = aws_iam_policy.cross_account_1[0].arn
  role       = aws_iam_role.cross_account_role.name
}

resource "aws_iam_policy" "cross_account_2" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name = "${local.deployment_name}-ca-2"
  policy = templatefile("${path.module}/../templates/vpc_cross_account_policy_2.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
    REGION          = local.region
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cross_account_2" {
  count = local.is_deployment_type_vpc ? 1 : 0

  policy_arn = aws_iam_policy.cross_account_2[0].arn
  role       = aws_iam_role.cross_account_role.name
}

resource "aws_iam_policy" "cross_account_eks" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name = "${local.deployment_name}-ca-eks"
  policy = templatefile("${path.module}/../templates/vpc_cross_account_eks_policy.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
    REGION          = local.region
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cross_account_eks" {
  count = local.is_deployment_type_vpc ? 1 : 0

  policy_arn = aws_iam_policy.cross_account_eks[0].arn
  role       = aws_iam_role.cross_account_role.name
}

resource "aws_iam_policy" "cross_account_eks_vpc_endpoint" {
  count = local.is_deployment_type_vpc && var.enable_eks_ingress_vpc_endpoint ? 1 : 0

  name = "${local.deployment_name}-ca-eks-vpce"
  policy = templatefile("${path.module}/../templates/vpc_cross_account_eks_vpc_endpoint_policy.json", {
    DEPLOYMENT_NAME = local.deployment_name
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cross_account_eks_vpc_endpoint" {
  count = local.is_deployment_type_vpc && var.enable_eks_ingress_vpc_endpoint ? 1 : 0

  policy_arn = aws_iam_policy.cross_account_eks_vpc_endpoint[0].arn
  role       = aws_iam_role.cross_account_role.name
}

resource "aws_iam_policy" "cross_account_elasticache" {
  count = local.is_deployment_type_vpc && var.enable_elasticache ? 1 : 0

  name = "${local.deployment_name}-ca-elasticache"
  policy = templatefile("${path.module}/../templates/vpc_cross_account_elasticache_policy.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
    REGION          = local.region
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cross_account_elasticache" {
  count = local.is_deployment_type_vpc && var.enable_elasticache ? 1 : 0

  policy_arn = aws_iam_policy.cross_account_elasticache[0].arn
  role       = aws_iam_role.cross_account_role.name
}
