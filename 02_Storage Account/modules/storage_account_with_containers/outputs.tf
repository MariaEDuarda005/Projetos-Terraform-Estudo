output "storage_account_with_containers_name" {
  description = "The name of the Storage Account."
  value       = azurerm_storage_account.storage_account_with_containers.name
}

output "storage_account_with_containers_primary_endpoint" {
  description = "The primary endpoint for the Storage Account."
  value       = azurerm_storage_account.storage_account_with_containers.primary_blob_endpoint
}