output "server_name" {
  description = "The name of the MySQL server."
  value       = azurerm_mysql_flexible_server.server.name
}
