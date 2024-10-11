terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    
  }
}

provider "azurerm" {
  features {}
}


