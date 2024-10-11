output "containers_subnet_id" {
  value = azurerm_subnet.containers-subnet.id
}

output "network_profile_id" {
  value = azurerm_network_profile.containergroup_profile.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
  description = "The ID of the Virtual Network"
}

output "full_dns_label" {
  value = "${var.domain_name_label}.germanywestcentral.cloudapp.azure.com"
}

output "gateway_public_ip" {
  value = azurerm_public_ip.gateway_public_ip.id
  
}

output "gateway_subnet_id" {
  value = azurerm_subnet.gateway_subnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}