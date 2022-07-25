data "aws_caller_identity" "current" {}
data "aws_caller_identity" "databricks" {
  provider = aws.databricks
}
data "aws_region" "current" {}
