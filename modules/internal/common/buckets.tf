resource "aws_s3_bucket" "tecton" {
  count = local.is_deployment_type_vpc ? 0 : 1

  bucket = local.deployment_name
  tags   = local.tags

  lifecycle {
    ignore_changes = [lifecycle_rule]
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tecton" {
  count = local.is_deployment_type_vpc ? 0 : 1

  bucket = aws_s3_bucket.tecton[0].bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_owner_enforced" {
  count = local.is_deployment_type_vpc ? 0 : 1

  bucket = aws_s3_bucket.tecton[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_acl" "tecton" {
  count = local.is_deployment_type_vpc ? 0 : 1

  bucket = aws_s3_bucket.tecton[0].id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "read_only_access" {
  count = length(var.additional_s3_read_only_principals) > 0 && !local.is_deployment_type_vpc ? 1 : 0

  bucket = aws_s3_bucket.tecton[0].bucket
  policy = data.aws_iam_policy_document.tecton_s3_read_only_access[0].json
}

data "aws_iam_policy_document" "tecton_s3_read_only_access" {
  count = local.is_deployment_type_vpc ? 0 : 1

  version = "2012-10-17"
  statement {
    sid    = "AllowReadOnlyAccess"
    effect = "Allow"
    principals {
      identifiers = var.additional_s3_read_only_principals
      type        = "AWS"
    }
    actions = ["s3:Get*", "s3:List*"]
    resources = [
      aws_s3_bucket.tecton[0].arn,
      format("%s/*", aws_s3_bucket.tecton[0].arn),
    ]
  }
}
