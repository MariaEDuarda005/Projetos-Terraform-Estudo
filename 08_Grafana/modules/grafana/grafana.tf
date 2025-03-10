resource "azurerm_dashboard_grafana" "grafana" {
  name                              = var.grafana_name 
  location                          = var.resource_group_location
  resource_group_name               = var.resource_group_name
  grafana_major_version             = var.grafana_version
  api_key_enabled                   = var.api_key
  deterministic_outbound_ip_enabled = var.grafana_ip_enabled
  public_network_access_enabled     = var.public_network
  zone_redundancy_enabled           = var.zone_redundancy

  identity {
    type = var.identity_type
  }

  tags = var.tags
}