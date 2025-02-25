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

variable "prefix" {
  default = "maria-terraform"
}

# Grupo de recursos
resource "azurerm_resource_group" "rg-tf" {
  name     = "${var.prefix}-dev"
  location = "East US"
}

resource "azurerm_postgresql_server" "server" {
  name                = "postgresql-server-terraform"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name

  sku_name = "B_Gen5_2" # unidade de desempenho e capacidade - 2 vCores, Gen 5 com maior capacidade

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "psqladmin"
  administrator_login_password = "G5#r8K@t2Q!x"

  version                 = "11"
  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "database" {
  name                = "terraformdb"  // nome do banco de dados
  resource_group_name = azurerm_resource_group.rg-tf.name
  server_name         = azurerm_postgresql_server.server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

# Regra de firewall para permitir o acesso de qualquer IP 
resource "azurerm_postgresql_firewall_rule" "allow_public_ip" {
  name                = "allow-public-ip"
  server_name         = azurerm_postgresql_server.server.name
  resource_group_name = azurerm_resource_group.rg-tf.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}