resource "random_string" "acr_suffix" {
  length  = 8
  upper   = false
  lower   = true
  special = false
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}${random_string.acr_suffix.result}"  # Make it unique
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  admin_enabled       = true

 
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id   = var.identity_principal_id
  role_definition_name = "AcrPull"
  scope          = azurerm_container_registry.acr.id
}
