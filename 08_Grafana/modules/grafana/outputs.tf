output "grafana_name" {
  description = "The name of the Grafana dashboard."
  value       = azurerm_dashboard_grafana.grafana.name
}