output "firewall_rule_name" {
  description = "The name of the firewall rule."
  value       = azurerm_mysql_flexible_server_firewall_rule.allow_public_ip.name
}
