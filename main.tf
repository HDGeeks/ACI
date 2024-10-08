
terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "./resource_group"
  resource_group_name = "Serverless-Demo"
  location            = "Germany West Central"
}

module "vnet" {
  depends_on = [ module.resource_group ]
  source = "./vnet"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vnet_name           = "demo-vnet"
  subnet_name         = "containers-subnet"
}

module "identity" {
  source = "./managed_identity"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  identity_name       = "container-identity"
}

module "acr" {
  source               = "./acr"
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.resource_group_location
  acr_name              = "myacrregistry"
  identity_principal_id = module.identity.identity_principal_id
}

module "load_balancer" {
  source              = "./loadbalancer"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  prefix              = "demo"
  subnet_id = module.vnet.subnet_id

 
}


module "container" {
 
  source               = "./containers"
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.resource_group_location
  container_name        = "my-container"
  acr_login_server      = module.acr.acr_login_server
  identity_id           = module.identity.identity_id
  subnet_id             = module.vnet.subnet_id
  network_profile_id    = module.vnet.network_profile_id
  tags                  = { environment = "production" }
  virtual_network_id = module.vnet.vnet_id
  backend_address_pool_id = module.load_balancer.backend_address_pool_id
  backend_address_pool_name = module.load_balancer.backend_address_pool_name

}


# module "application_gateway" {
#   source = "./app_gateway"

#   name                    = "myAppGateway"
#   location                = module.resource_group.resource_group_location
#   resource_group_name     = module.resource_group.resource_group_name
#   sku_name                = "Standard_v2"
#   sku_tier                = "Standard_v2"
#   sku_capacity            = 2
#   backend_service_fqdn    = "your-backend-service.example.com"  # Update with your actual backend service FQDN
#   ssl_cert_path           = "path/to/your/certificate.pfx"  # Path to your SSL certificate
#   ssl_cert_password        = "your_password"  # Password for the PFX file
#   public_ip_name          = "myPublicIP"
#   subnet_id = module.vnet.subnet_id
#   target-group = module.load_balancer.backend_address_pool_id
  
# }
