






output "gateway_name" {
  value = azurerm_application_gateway.appgtw.name
}

# Output the list of usable IP addresses
output "usable_ip_addresses" {
  value = local.usable_ips
}

