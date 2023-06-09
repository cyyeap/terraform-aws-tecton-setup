locals {
  tags = merge(var.tags, { "tecton-accessible:${var.deployment_name}" : "true" })
}

resource "aws_iam_policy" "emr_debugging_policy" {
  name = "tecton-${var.deployment_name}-cross-account-emr-debugging"
  policy = templatefile("${path.module}/../../templates/emr_debugging_policy.json", {
    DEPLOYMENT_NAME = var.deployment_name
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "emr_debugging_policy" {
  role       = var.cross_account_role_name
  policy_arn = aws_iam_policy.emr_debugging_policy.arn
}

data "aws_iam_policy" "emr_full_access" {
  name = "AmazonEMRFullAccessPolicy_v2"
}

resource "aws_iam_role_policy_attachment" "emr_full_access" {
  role       = var.cross_account_role_name
  policy_arn = data.aws_iam_policy.emr_full_access.arn
}
