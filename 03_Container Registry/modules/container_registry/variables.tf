variable "resource_group_name" {
  description = "The name of the resource group where ACR will be created."
  type        = string
}

variable "resource_group_location" {
  description = "The geographical location where the resource group will be created."
  type        = string
  validation {
    condition     = length(var.resource_group_location) > 0
    error_message = "The resource group location cannot be empty."
  }
}

variable "container_registry_name" {
  description = "The name of the container registry."
  type        = string
  validation {
    condition = length(var.container_registry_name) > 0
    error_message = "The name of the container registry cannot be empty."
  }
}

variable "container_registry_sku" {
  description = "The SKU for the container registry (Basic, Standard, Premium)."
  type        = string
  default     = "Standard"
}

variable "container_registry_admin_enabled" {
  description = "Whether the admin user for the container registry should be enabled."
  type        = bool
  default     = false
}