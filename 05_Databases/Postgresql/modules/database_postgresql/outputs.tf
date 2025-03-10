output "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  value       = azurerm_postgresql_server.server.name
}

output "postgresql_database_name" {
  description = "The name of the PostgreSQL database."
  value       = azurerm_postgresql_database.database.name
}

output "postgresql_server_url" {
  description = "The URL of the PostgreSQL server."
  value       = azurerm_postgresql_server.server.fqdn
}
