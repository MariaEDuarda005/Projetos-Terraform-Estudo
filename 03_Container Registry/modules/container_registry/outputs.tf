output "container_registry_name" {
  description = "The name of the container registry created."
  value       = azurerm_container_registry.acr-tf.name
}

output "container_registry_id" {
  description = "The ID of the container registry created."
  value       = azurerm_container_registry.acr-tf.id
}
