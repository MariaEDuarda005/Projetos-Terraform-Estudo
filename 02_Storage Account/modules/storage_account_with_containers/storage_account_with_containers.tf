resource "azurerm_storage_account" "storage_account_with_containers" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  min_tls_version          = var.storage_account_min_tls_version

  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "storage_account_container_1" {
  name                  = var.storage_account_container_1_name
  storage_account_name  = azurerm_storage_account.storage_account_with_containers.name
  container_access_type = var.storage_account_container_1_access_type
}

resource "azurerm_storage_container" "storage_account_container_2" {
  name                  = var.storage_account_container_2_name
  storage_account_name  = azurerm_storage_account.storage_account_with_containers.name
  container_access_type = var.storage_account_container_2_access_type
}