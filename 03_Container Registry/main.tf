# código de inicialização do terraform
terraform {
  required_version = ">=1.10.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-tf" {
  name     = "maria-terraform-dev"
  location = "East US"
}

resource "azurerm_container_registry" "acr-tf" {
  name                = "containerRegistryTerraform"
  resource_group_name = azurerm_resource_group.rg-tf.name
  location            = azurerm_resource_group.rg-tf.location
  sku                 = "Standard"
  admin_enabled       = false
}