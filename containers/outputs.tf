

output "staging_container_id" {
  value = azurerm_container_group.staging.id
}

# output "production_container_id" {
#   value = azurerm_container_group.production.id
# }
# output "production_container_ip" {
#   description = "The public IP address of the production container."
#   value       = azurerm_container_group.production.ip_address
# }
output "staging_container_ip" {
  description = "The public IP address of the staging container."
  value       = azurerm_container_group.staging.ip_address
}
