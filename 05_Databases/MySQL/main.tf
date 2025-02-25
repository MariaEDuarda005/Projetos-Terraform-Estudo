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

resource "azurerm_mysql_flexible_server" "server" {
  name                   = "mysql-server-terraform"
  resource_group_name    = azurerm_resource_group.rg-tf.name
  location               = azurerm_resource_group.rg-tf.location
  administrator_login    = "mysqladminun"
  administrator_password = "H@Sh1CoR3!"
  sku_name               = "B_Standard_B1s"
}

resource "azurerm_mysql_flexible_database" "database" {
  name                = "terraformdb"
  resource_group_name = azurerm_resource_group.rg-tf.name
  server_name         = azurerm_mysql_flexible_server.server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_public_ip" {
  name                = "allow-public-ip"
  server_name         = azurerm_mysql_flexible_server.server.name
  resource_group_name = azurerm_resource_group.rg-tf.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
