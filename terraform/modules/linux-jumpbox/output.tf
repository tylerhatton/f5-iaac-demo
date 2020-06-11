output "jumpbox_ip" {
  value       = aws_eip.jumpbox_mgmt.public_ip
  description = "The mgmt IP of the Jumpbox."
}

output "jumpbox_username" {
  value       = var.default_username
  description = "The username for the jumpbox."
}

output "jumpbox_password" {
  value       = random_password.password.result
  description = "The password for the jumpbox."
}