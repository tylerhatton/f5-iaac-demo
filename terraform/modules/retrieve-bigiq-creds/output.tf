output "bigiq_server" {
  value = jsondecode(data.aws_secretsmanager_secret_version.bigiq_secret.secret_string)["server"]
}

output "bigiq_username" {
  value = jsondecode(data.aws_secretsmanager_secret_version.bigiq_secret.secret_string)["username"]
}

output "bigiq_password" {
  value = jsondecode(data.aws_secretsmanager_secret_version.bigiq_secret.secret_string)["password"]
}

output "license_pool" {
  value = jsondecode(data.aws_secretsmanager_secret_version.bigiq_secret.secret_string)["license_pool"]
}