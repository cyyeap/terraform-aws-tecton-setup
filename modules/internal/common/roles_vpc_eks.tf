resource "aws_iam_role" "eks_management_role" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name               = "${local.deployment_name}-eks-management-role"
  tags               = local.tags
  assume_role_policy = data.aws_iam_policy_document.eks_management_role[0].json
}

data "aws_iam_policy_document" "eks_management_role" {
  count = local.is_deployment_type_vpc ? 1 : 0

  statement {
    effect = "Allow"
    principals {
      identifiers = ["eks.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "eks_management_policy" {
  for_each = local.is_deployment_type_vpc ? toset([
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  ]) : []

  policy_arn = each.value
  role       = aws_iam_role.eks_management_role[0].name
}

resource "aws_iam_role" "eks_node_role" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name               = "${local.deployment_name}-eks-worker-role"
  tags               = local.tags
  assume_role_policy = data.aws_iam_policy_document.eks_node_role[0].json
}

data "aws_iam_policy_document" "eks_node_role" {
  count = local.is_deployment_type_vpc ? 1 : 0

  statement {
    effect = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "eks_node_policy" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name = "${local.deployment_name}-eks-worker-policy"
  policy = templatefile("${local.templates_dir}/vpc_cross_account_eks_policy.json",
    {
      ACCOUNT_ID      = local.account_id
      DEPLOYMENT_NAME = var.deployment_name
      REGION          = local.region
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  count = local.is_deployment_type_vpc ? 1 : 0

  policy_arn = aws_iam_policy.eks_node_policy[0].arn
  role       = aws_iam_role.eks_node_role[0].name
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  for_each = local.is_deployment_type_vpc ? toset([
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]) : []
  policy_arn = each.value
  role       = aws_iam_role.eks_node_role[0].name
}
