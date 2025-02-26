# Código de inicialização do Terraform
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
  resource_group_name     = "terraform-project-${local.environment_prefix}"
  resource_group_location = "East US"
  tags = {
    Project      = "terraform-project-${local.environment_prefix}"
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

module "acr" {
  source = "./modules/container_registry"

  resource_group_name              = module.azurerg.resource_group_name
  resource_group_location          = module.azurerg.resource_group_location
  container_registry_name          = "terraformprojectacr"
  container_registry_sku           = "Premium"
  container_registry_admin_enabled = true
}
