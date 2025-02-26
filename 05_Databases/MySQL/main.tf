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

module "mysql_server" {
  source = "./modules/server"

  resource_group_name     = module.azurerg.resource_group_name
  resource_group_location = module.azurerg.resource_group_location
  server_name             = "mysql-server-terraform"
  administrator_login     = "mysqladminun"
  administrator_password  = "H@Sh1CoR3!"
  sku_name                = "B_Standard_B1s"
}

module "mysql_database" {
  source = "./modules/database_mysql"

  resource_group_name = module.azurerg.resource_group_name
  server_name         = module.mysql_server.server_name
  database_name       = "terraformdb"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

module "mysql_firewall_rule" {
  source = "./modules/firewall"

  allow_public_ip_name = "allow-public-ip"
  resource_group_name  = module.azurerg.resource_group_name
  server_name          = module.mysql_server.server_name
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "255.255.255.255"
}
