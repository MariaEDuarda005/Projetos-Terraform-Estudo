resource "azurerm_postgresql_server" "server" {
  name                = var.server_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name 

  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  auto_grow_enabled            = var.auto_grow_enabled

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  version                 = var.postgresql_version
  ssl_enforcement_enabled = var.ssl_enforcement_enabled
}


resource "azurerm_postgresql_database" "database" {
  name                = var.name_database
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  charset             = var.charset
  collation           = var.collation
}


resource "azurerm_postgresql_firewall_rule" "allow_public_ip" {
  name                = var.allow_public_ip_name
  server_name         = azurerm_postgresql_server.server.name
  resource_group_name = var.resource_group_name
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address
}