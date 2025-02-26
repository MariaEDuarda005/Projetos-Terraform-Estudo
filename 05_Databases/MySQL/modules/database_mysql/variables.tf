variable "database_name" {
  description = "The name of the MySQL database."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "server_name" {
  description = "The name of the MySQL server."
  type        = string
}

variable "charset" {
  type = string
}

variable "collation" {
  type = string
}
