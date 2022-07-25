resource "aws_iam_policy" "tecton_secrets" {
  count = local.is_deployment_type_vpc ? 1 : 0

  name        = "${local.deployment_name}-secrets-emr"
  description = "Allow access to Tecton scoped secrets."
  policy = templatefile("${local.templates_dir}/spark_policy_emr.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cross_account_databricks" {
  count = local.is_deployment_type_vpc ? 1 : 0

  policy_arn = aws_iam_policy.tecton_secrets[0].arn
  role       = local.spark_role_name
}
