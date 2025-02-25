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

# App Service Plan
resource "azurerm_service_plan" "asp-tf" {
  name                = "terraform-asp"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
  sku_name            = "S1"
  os_type             = "Linux"
}

# App Service
resource "azurerm_app_service" "ap-tf" {
  name                = "terraform-backend"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
  app_service_plan_id = azurerm_service_plan.asp-tf.id  
}

# Criando o Banco de Dados
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

# Container Registry
resource "azurerm_container_registry" "acr-tf" {
  name                = "containerRegistryTerraform"
  resource_group_name = azurerm_resource_group.rg-tf.name
  location            = azurerm_resource_group.rg-tf.location
  sku                 = "Standard"
  admin_enabled       = false
}

# Storage account
resource "azurerm_storage_account" "sa-tf" {
  name                     = "terraformstgaccount"
  resource_group_name      = azurerm_resource_group.rg-tf.name
  location                 = azurerm_resource_group.rg-tf.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Event Grid System Topic
resource "azurerm_eventgrid_system_topic" "event-tf" {
  name                   = "terraform-topic"
  resource_group_name    = azurerm_resource_group.rg-tf.name
  location               = azurerm_resource_group.rg-tf.location
  source_arm_resource_id = azurerm_storage_account.sa-tf.id
  topic_type             = "Microsoft.Storage.StorageAccounts"
}
