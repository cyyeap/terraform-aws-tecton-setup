resource "aws_secretsmanager_secret" "deployment_info" {
  count = var.deployment_info != null ? 1 : 0

  name = "${var.deployment_name}/DEPLOYMENT_INFO"

  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "deployment_info" {
  count = var.deployment_info != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.deployment_info[0].id
  secret_string = jsonencode(var.deployment_info)
}
