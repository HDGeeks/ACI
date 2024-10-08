resource "azurerm_container_group" "staging" {
  name                = "staging-container"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  restart_policy = var.restart_policy
  network_profile_id = var.network_profile_id
  ip_address_type = "Private"

  
  container {
    name   = "staging-flask-app"
    image  = var.image
    cpu    = "0.5"
    memory = "1"

    ports {
      port     = 80  # The internal port that Flask runs on
      protocol = "TCP"
    }

   
 
  }



  identity {
    type = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  tags = {
    environment = "staging"
  }
}



resource "azurerm_container_group" "production" {
  name                = "production-container"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  restart_policy = var.restart_policy
  network_profile_id = var.network_profile_id
  ip_address_type = "Private"
  



 container {
    name   = "production-flask-app"
    image  = var.image  # Change this when the image is available
    cpu    = "0.5"
    memory = "1"

    ports {
      port     = 80  # The internal port that Flask runs on
      protocol = "TCP"
    }


}



  identity {
    type = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  tags = {
    environment = "production"
  }

  
}

resource "azurerm_lb_backend_address_pool_address" "container-staging" {
  name                    = "staging-container"
  backend_address_pool_id = var.backend_address_pool_id
  virtual_network_id      = var.virtual_network_id
  ip_address              = azurerm_container_group.staging.ip_address

}

resource "azurerm_lb_backend_address_pool_address" "container-production" {
  name                    = "production-container"
  backend_address_pool_id = var.backend_address_pool_id
  virtual_network_id      = var.virtual_network_id
  ip_address              = azurerm_container_group.production.ip_address

}