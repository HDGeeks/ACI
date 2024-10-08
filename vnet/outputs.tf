output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "network_profile_id" {
  value = azurerm_network_profile.containergroup_profile.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
  description = "The ID of the Virtual Network"
}
