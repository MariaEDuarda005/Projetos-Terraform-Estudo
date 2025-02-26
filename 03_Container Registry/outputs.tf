## standard info
output "resource_group_name" {
  description = "The name of the resource group created."
  value       = module.azurerg.resource_group_name
}

output "resource_group_location" {
  description = "The location of the resource group."
  value       = module.azurerg.resource_group_location
}

output "resource_group_id" {
  description = "The ID of the resource group created."
  value       = module.azurerg.resource_group_id
}

# Container Registry
output "container_registry_name" {
  description = "The name of the container registry created."
  value       = module.acr.container_registry_name
}