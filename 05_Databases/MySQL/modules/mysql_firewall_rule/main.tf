resource "azurerm_mysql_flexible_server_firewall_rule" "allow_public_ip" {
  name                = var.allow_public_ip_name
  server_name         = var.server_name
  resource_group_name = var.resource_group_name
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address
}
