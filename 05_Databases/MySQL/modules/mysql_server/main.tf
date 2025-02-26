resource "azurerm_mysql_flexible_server" "server" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location
  administrator_login    = var.administrator_login # "mysqladminun"
  administrator_password = var.administrator_password # "H@Sh1CoR3!"
  sku_name               = var.sku_name # "B_Standard_B1s"
}
