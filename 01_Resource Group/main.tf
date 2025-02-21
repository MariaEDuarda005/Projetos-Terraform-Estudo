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

# Criar Resource Group para todos os recursos
# rg-tf -> nome que vai ser usado sempre que for referenciar, mas não é o nome do recurso
resource "azurerm_resource_group" "rg-tf" {
  name     = "maria-terraform-dev"
  location = "East US"
}