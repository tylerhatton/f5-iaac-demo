output "vpc_id" {
  value       = aws_vpc.f5_openshift_demo.id
  description = "The ID of the VPC."
}

output "mgmt_subnet_id" {
  value       = aws_subnet.f5_openshift_mgmt.id
  description = "The ID of the management subnet."
}

output "external_subnet_id" {
  value       = aws_subnet.f5_openshift_external.id
  description = "The ID of the external subnet."
}

output "internal_subnet_id" {
  value       = aws_subnet.f5_openshift_internal.id
  description = "The ID of the internal subnet."
}