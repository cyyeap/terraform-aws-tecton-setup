# TODO: go through this file + move/cover in cross + spark files

data "aws_iam_role" "spark_role" {
  name = var.spark_role_name
}

resource "aws_iam_role" "cross_account_databricks_tecton_access" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name                 = "${local.deployment_name}-cross-account-databricks"
  max_session_duration = 43200
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.cross_account_databricks_tecton_access[0].json
}

data "aws_iam_policy_document" "cross_account_databricks_tecton_access" {
  count = local.is_deployment_type_vpc ? 1 : 0

  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        format("arn:aws:iam::%s:root", local.databricks_account_id)
      ]
      type = "AWS"
    }
    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [random_id.external_id[0].id]
    }
  }
}

resource "random_id" "external_id" {
  count = local.is_deployment_type_vpc ? 1 : 0

  byte_length = 16
}

resource "aws_iam_policy" "cross_account_databricks_tecton_access" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name        = "${local.deployment_name}-cross-account-databricks"
  description = "Allow Databricks account assume-role access to the spark-access role."
  policy = templatefile("${local.templates_dir}/vpc_cross_account_databricks_tecton_access.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
    REGION          = local.region
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cross_account" {
  count = local.is_deployment_type_vpc ? 1 : 0

  policy_arn = aws_iam_policy.cross_account_databricks_tecton_access[0].arn
  role       = aws_iam_role.cross_account_databricks_tecton_access[0].name
}

resource "aws_iam_policy" "cross_account_from_databricks" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name        = "${local.deployment_name}-cross-account"
  description = "Allow Databricks access to Tecton spark-access role."
  policy = templatefile("${local.templates_dir}/vpc_cross_account_databricks_to_tecton_access.json", {
    ROLE_ARN = aws_iam_role.cross_account_databricks_tecton_access[0].arn
  })
  tags = local.tags

  provider = aws.databricks
}

resource "aws_iam_role_policy_attachment" "cross_account_databricks" {
  count = local.is_deployment_type_vpc ? 1 : 0

  policy_arn = aws_iam_policy.cross_account_from_databricks[0].arn
  role       = var.spark_role_name

  provider = aws.databricks
}
