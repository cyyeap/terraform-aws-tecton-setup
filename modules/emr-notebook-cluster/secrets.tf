resource "aws_secretsmanager_secret" "api_service" {
  name = "tecton-${var.deployment_name}/API_SERVICE"
}

resource "aws_secretsmanager_secret_version" "api_service" {
  secret_id     = aws_secretsmanager_secret.api_service.id
  secret_string = "https://${var.deployment_name}.tecton.ai/api"
}

resource "aws_secretsmanager_secret" "tecton_api_key" {
  name = "tecton-${var.deployment_name}/TECTON_API_KEY"
}
