resource "aws_iam_policy" "spark_access_emr" {
  name = "${local.deployment_name}-spark-access-emr"
  policy = templatefile("${local.templates_dir}/emr_ca_policy.json", {
    ACCOUNT_ID       = local.account_id
    DEPLOYMENT_NAME  = local.deployment_name
    REGION           = local.region
    EMR_MANAGER_ROLE = aws_iam_role.master_role.name
    SPARK_ROLE       = aws_iam_role.spark_role.name
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "spark_access_emr" {
  policy_arn = aws_iam_policy.spark_access_emr.arn
  role       = var.spark_access_role
}

resource "aws_iam_role" "spark_role" {
  name               = local.spark_role_name
  tags               = local.tags
  assume_role_policy = data.aws_iam_policy_document.spark_role.json
}

data "aws_iam_policy_document" "spark_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_policy" "emr_spark_policy" {
  name = "${local.deployment_name}-spark-policy-emr"
  policy = templatefile("${local.templates_dir}/spark_policy.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
    REGION          = local.region
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "emr_spark_policy_attachment" {
  policy_arn = aws_iam_policy.emr_spark_policy.arn
  role       = aws_iam_role.spark_role.name
}

resource "aws_iam_role_policy_attachment" "emr_ssm_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.spark_role.name
}

resource "aws_iam_instance_profile" "spark" {
  name = "${local.deployment_name}-spark-emr"
  role = aws_iam_role.spark_role.name
}

resource "aws_iam_role" "master_role" {
  name               = "${local.deployment_name}-master-role-emr"
  tags               = local.tags
  assume_role_policy = data.aws_iam_policy_document.master_role.json
}

data "aws_iam_policy_document" "master_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["elasticmapreduce.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_policy" "master_policy" {
  name = "${local.deployment_name}-master-policy-emr"
  policy = templatefile("${local.templates_dir}/emr_master_policy.json", {
    ACCOUNT_ID      = local.account_id
    DEPLOYMENT_NAME = local.deployment_name
    REGION          = local.region
    SPARK_ROLE      = aws_iam_role.spark_role.name
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "emr_master_policy_attachment" {
  policy_arn = aws_iam_policy.master_policy.arn
  role       = aws_iam_role.master_role.name
}

# VPC

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
