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

  resource_group_name     = local.resource_group_name
  resource_group_location = local.resource_group_location
  tags                    = local.tags
}

module "database_postgresql" {
  source = "./modules/database_postgresql" # C:\Users\FMR8CA\Desktop\Projetos-Terraform-Estudo\05_Databases\Postgresql\modules\database_postgresql

  resource_group_name          = local.resource_group_name
  resource_group_location      = local.resource_group_location
  server_name                  = "mariaterraform-postgresql-server"
  sku_name                     = "B_Gen5_1"
  administrator_login          = "psqladmin"
  administrator_login_password = "G5#r8K@t2Q!x"
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true
  postgresql_version           = "11"
  ssl_enforcement_enabled      = true
  storage_mb                   = 5120
  name_database                = "terraformdb"
  charset                      = "UTF8"
  collation                    = "English_United States.1252"
  allow_public_ip_name         = "allow-public-ip"
  start_ip_address             = "0.0.0.0"
  end_ip_address               = "255.255.255.255"
}