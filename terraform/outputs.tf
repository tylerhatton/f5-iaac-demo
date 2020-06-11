output "f5_prd_mgmt_ip" {
  value       = module.f5_ltm_prd.f5_mgmt_ip
  description = "The mgmt IP of the F5 device."
}

output "f5_prd_admin_password" {
  value       = module.f5_ltm_prd.f5_admin_password
  description = "The admin password for the F5 mgmt console."
}

output "f5_dev_mgmt_ip" {
  value       = module.f5_ltm_dev.f5_mgmt_ip
  description = "The mgmt IP of the F5 device."
}

output "f5_dev_admin_password" {
  value       = module.f5_ltm_dev.f5_admin_password
  description = "The admin password for the F5 mgmt console."
}

output "jumpbox_mgmt_ip" {
  value       = module.jumpbox.jumpbox_ip
  description = "The mgmt IP of the Jumpbox."
}

output "jumpbox_username" {
  value       = module.jumpbox.jumpbox_username
  description = "The username for the Jumpbox."
}

output "jumpbox_password" {
  value       = module.jumpbox.jumpbox_password
  description = "The password for the Jumpbox."
}