resource "azurerm_mysql_flexible_database" "database" {
  name                = var.database_name # "terraformdb"
  resource_group_name = var.resource_group_name
  server_name         = var.server_name
  charset             = var.charset # "utf8"
  collation           = var.collation # "utf8_unicode_ci"
}

# output "database_name" {
#   value = azurerm_mysql_flexible_database.database.name
# }