/* ╭──────────────────────────────────────────────────────────╮
   │ Policy grants existing Databricks role (should           │
   │  already exist) access to Tecton resources               │
   ╰──────────────────────────────────────────────────────────╯
*/
resource "aws_iam_role_policy_attachment" "common_spark_policy_attachment" {
  policy_arn = aws_iam_policy.spark_access.arn
  role       = local.spark_role_name
  provider   = aws.databricks
}

resource "aws_iam_policy" "spark_access" {
  name     = format("tecton-%s-common-spark", var.deployment_name)
  policy   = data.aws_iam_policy_document.spark_access.json
  tags     = local.tags
  provider = aws.databricks
}

data "aws_iam_policy_document" "spark_access" {
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
      "dynamodb:BatchWriteItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:DescribeTable",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
    ]
  }

  statement {
    sid       = "DynamoDBGlobal"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["dynamodb:ListTables"]
  }

  statement {
    sid     = "S3Bucket"
    effect  = "Allow"
    actions = ["s3:ListBucket"]

    resources = concat(var.s3_bucket_arns, [
      "arn:aws:s3:::tecton.ai.databricks-init-scripts",
      "arn:aws:s3:::tecton.ai.public",
      "arn:aws:s3:::tecton-materialization-release",
    ])
  }

  statement {
    sid       = "S3Object"
    effect    = "Allow"
    resources = formatlist("%s/*", var.s3_bucket_arns)

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
  }

  statement {
    sid    = "TectonPublicS3"
    effect = "Allow"

    resources = [
      "arn:aws:s3:::tecton.ai.databricks-init-scripts/*",
      "arn:aws:s3:::tecton.ai.public/*",
      "arn:aws:s3:::tecton-materialization-release/*",
    ]

    actions = ["s3:GetObject"]
  }

  statement {
    sid    = "CrossAccountDynamoDBAccess"
    effect = "Allow"
    resources = [
      format(
        "arn:aws:iam::%s:role/tecton-%s-cross-account-spark-access",
        local.account_id_tecton,
        var.deployment_name,
      )
    ]
    actions = ["sts:AssumeRole"]
  }
}
