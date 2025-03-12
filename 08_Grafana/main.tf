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
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # Desabilitar a verificação se existe algum recurso dentro o grupo de recursos
    }
  }
}

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

module "azurerg" {
  source = "./modules/azurerg"

  resource_group_name = local.resource_group_name

  resource_group_location = local.resource_group_location
  tags                    = local.tags
}

module "grafana" {
  source = "./modules/grafana"

  grafana_name            = "grafana-${local.environment_prefix}-7886" # ⚠️ Unico #
  resource_group_location = local.resource_group_location
  resource_group_name     = local.resource_group_name
  grafana_version         = 10
  api_key                 = true
  grafana_ip_enabled      = true
  public_network          = true # deixar publico
  zone_redundancy         = false

  identity_type = "SystemAssigned"

  tags = {
    environment = "development"
    created_on  = "2025-03-10"
    service     = "monitoring"
  }
}