variable "server_name" {
  description = "The name of the MySQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login for the MySQL server."
  type        = string
}

variable "administrator_password" {
  description = "The administrator password for the MySQL server."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the MySQL server."
  type        = string
  default     = "B_Standard_B1s"
}
