
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
  resource_group_location = module.resource_group.resource_group_location

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
  acr_server = module.acr.acr_login_server

}

module "gateway" {


  source = "./gateway"
  vnet = module.network.vnet_name
  resource_group_name = module.resource_group.name
  resource_group_location = module.resource_group.resource_group_location
  gateway_subnet_id = module.vnet.gateway_subnet_id
  gateway_ip = module.network.gateway_public_ip

 
}



