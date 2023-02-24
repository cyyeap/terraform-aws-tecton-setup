/* ╭──────────────────────────────────────────────────────────╮
   │ IAM role which is used to write to the online store      │
   │  (DynamoDB) when Databricks lives in a separate          │
   │  account from the Tecton deployment                      │
   ╰──────────────────────────────────────────────────────────╯
*/
resource "aws_iam_role" "tecton_spark_cross_account" {
  count = local.is_databricks_in_tecton_account ? 0 : 1

  name                 = format("tecton-%s-cross-account-spark-access", var.deployment_name)
  max_session_duration = 43200
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json

  provider = aws.tecton
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = local.tecton_cross_account_role_trusted_arns
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [random_id.external_id[0].id]
    }
  }
}

resource "random_id" "external_id" {
  count = local.is_databricks_in_tecton_account ? 1 : 0

  byte_length = 16
}

resource "aws_iam_role_policy_attachment" "cross_account_databricks_policy_attachment" {
  count = local.is_databricks_in_tecton_account ? 0 : 1

  policy_arn = aws_iam_policy.cross_account_databricks[0].arn
  role       = aws_iam_role.tecton_spark_cross_account[0].name

  provider = aws.tecton
}

resource "aws_iam_policy" "cross_account_databricks" {
  count = local.is_databricks_in_tecton_account ? 0 : 1

  name   = format("tecton-%s-cross-account-databricks", var.deployment_name)
  policy = data.aws_iam_policy_document.tecton_spark_cross_account_access.json
  tags   = local.tags

  provider = aws.tecton
}

data "aws_iam_policy_document" "tecton_spark_cross_account_access" {
  statement {
    sid    = "DynamoDB"
    effect = "Allow"
    resources = [
      format(
        "arn:aws:dynamodb:%s:%s:table/tecton-%s*",
        local.region_tecton, # DynamoDB table will be created by Tecton provider
        local.account_id_tecton,
        var.deployment_name,
      )
    ]

    actions = [
      "dynamodb:ConditionCheckItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
  }

  statement {
    sid       = "DynamoDBListTables"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["dynamodb:ListTables"]
  }
}
