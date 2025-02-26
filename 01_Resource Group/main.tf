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

locals {
  environment_prefix      = "dev"
  resource_group_name     = "project-${local.environment_prefix}"
  resource_group_location = "East US"
  tags = {
    Project      = "project-${local.environment_prefix}"
    Owner        = "maria_ferreira"
    CreationDate = "25/02/2025"
    Environment  = local.environment_prefix
  }
}

module "azurerg" {
  source = "./modules/azurerg"

  resource_group_name     = local.resource_group_name
  resource_group_location = local.resource_group_location
  tags                    = local.tags
}