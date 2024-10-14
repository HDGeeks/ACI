resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/24"]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "containers-subnet" {
  name                 = var.container_subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/25"]

  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "acidelegationservice"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

# Second half of the subnet (10.0.0.128 - 10.0.0.255)
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "Gateway-Subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.128/25"]  # Second 128 addresses
}

resource "azurerm_public_ip" "gateway_public_ip" {
  name                = "gateway_public_ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = var.domain_name_label
  sku = "Standard"


}



resource "azurerm_network_profile" "containergroup_profile" {
  depends_on = [ azurerm_virtual_network.vnet ]
  name                = "acg-profile"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  

  container_network_interface {
    name = "acg-nic"

    ip_configuration {
      name      = "aciipconfig"
      subnet_id = azurerm_subnet.containers-subnet.id
      
    
      
    }
  }
}



