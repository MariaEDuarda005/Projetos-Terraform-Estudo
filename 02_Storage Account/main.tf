terraform {
  required_version = ">=1.7.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "terraform-state"       #⚠️#
  #   storage_account_name = "statefilesdevsa"       #⚠️#
  #   container_name       = "projectdevtfstate"     #⚠️#
  #   key                  = "dev.terraform.tfstate" #⚠️#
  # }
}

provider "azurerm" {
  features {}
}

#################################################

locals {
  environment_prefix      = "dev"
  resource_group_name     = "terraform-${local.environment_prefix}"
  resource_group_location = "East US"
  tags = {
    Project      = "terraform-${local.environment_prefix}" #⚠️#
    Owner        = "maria_ferreira"                        #⚠️#
    CreationDate = "21/02/2025"                            #⚠️#
    Environment  = local.environment_prefix                #⚠️#
  }
}

#################################################

module "azurerg" {
  source = "./modules/azurerg"

  resource_group_name     = local.resource_group_name
  resource_group_location = local.resource_group_location
  tags                    = local.tags
}

module "storage_account_with_containers" {
  source = "./modules/storage_account_with_containers"

  resource_group_name                     = local.resource_group_name
  resource_group_location                 = local.resource_group_location
  storage_account_name                    = "mariaterraform${local.environment_prefix}sa"
  storage_account_tier                    = "Standard" # Options: Standard, Premium ⚠️#
  storage_account_replication_type        = "LRS"      # Options: GRS, RAGRS, ZRS, GZRS, RAGZRS ⚠️#
  storage_account_min_tls_version         = "TLS1_2"   # Options: TLS1_0, TLS1_1, TLS1_2 ⚠️#
  storage_account_container_1_name        = "container1"
  storage_account_container_2_name        = "container2"
  storage_account_container_1_access_type = "private" # Options: private, blob, container ⚠️#
  storage_account_container_2_access_type = "private" # Options: private, blob, container ⚠️#

  depends_on = [module.azurerg]
}