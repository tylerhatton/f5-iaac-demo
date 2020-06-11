data "aws_secretsmanager_secret" "bigiq_secret" {
  name = var.bigiq_secret_name
}

data "aws_secretsmanager_secret_version" "bigiq_secret" {
  secret_id = data.aws_secretsmanager_secret.bigiq_secret.id
}

