resource "aws_iam_role" "cross_account" {
  name                 = "${local.deployment_name}-cross-account"
  assume_role_policy   = data.aws_iam_policy_document.cross_account.json
  max_session_duration = 43200
  tags                 = local.tags
}

data "aws_iam_policy_document" "cross_account" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = formatlist("arn:aws:iam::%s:root", var.cross_account_assume_role_allowed_ids)
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [local.cross_account_external_id]
    }
  }
}

resource "aws_iam_policy" "cross_account" {
  name = "${local.deployment_name}-cross-account"
  policy = templatefile("${local.templates_dir}/ca_policy.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
    REGION          = local.region
    SPARK_ROLE      = var.spark_role_name
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cross_account" {
  policy_arn = aws_iam_policy.cross_account.arn
  role       = aws_iam_role.cross_account.name
}

resource "aws_iam_policy" "common_spark" {
  name = "${local.deployment_name}-common-spark"
  policy = templatefile("${local.templates_dir}/spark_policy.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
    REGION          = local.region
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "common_spark" {
  policy_arn = aws_iam_policy.common_spark.arn
  role       = var.spark_role_name
}
