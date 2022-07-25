resource "aws_iam_service_linked_role" "spot" {
  count = var.enable_spot_service_linked_role ? 1 : 0

  aws_service_name = "spot.amazonaws.com"
}

resource "aws_iam_service_linked_role" "eks_nodegroup" {
  count = local.is_deployment_type_vpc && var.enable_eks_nodegroup_service_linked_role ? 1 : 0

  aws_service_name = "eks-nodegroup.amazonaws.com"
}
