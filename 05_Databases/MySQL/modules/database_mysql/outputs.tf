output "database_name" {
  description = "The name of the MySQL database."
  value       = azurerm_mysql_flexible_database.database.name
}
