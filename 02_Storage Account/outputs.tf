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

## storage account info
output "storage_account_with_containers_name" {
  description = "The name of the Storage Account."
  value       = module.storage_account_with_containers.storage_account_with_containers_name
}

output "storage_account_with_containers_primary_endpoint" {
  description = "The primary endpoint for the Storage Account."
  value       = module.storage_account_with_containers.storage_account_with_containers_primary_endpoint
}
