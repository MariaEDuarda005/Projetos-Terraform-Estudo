variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}

variable "server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL server (e.g., B_Gen5_1)."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name for PostgreSQL server."
  type        = string
  default     = "psqladmin"  # Pode ser substituído por outro valor ou variável
}

variable "administrator_login_password" {
  description = "The password for the PostgreSQL administrator login."
  type        = string
  sensitive   = true  # Esta variável não será registrada no Terraform Plan para segurança
}

variable "backup_retention_days" {
  description = "The number of days to retain backups for PostgreSQL server."
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Whether geo-redundant backups are enabled for the PostgreSQL server."
  type        = bool
  default     = false
}

variable "auto_grow_enabled" {
  description = "Whether auto-grow is enabled for PostgreSQL storage."
  type        = bool
  default     = true
}

variable "postgresql_version" {
  description = "The version of PostgreSQL to use."
  type        = string
  default     = "11"
}

variable "ssl_enforcement_enabled" {
  description = "Whether SSL enforcement is enabled for PostgreSQL server."
  type        = bool
  default     = true
}

variable "storage_mb" {
  description = "The storage size for the PostgreSQL server in MB."
  type        = number
  default     = 5120
}

variable "start_ip_address" {
  description = "The starting IP address for the firewall rule."
  type        = string
  default     = "0.0.0.0"
}

variable "end_ip_address" {
  description = "The ending IP address for the firewall rule."
  type        = string
  default     = "255.255.255.255"
}

variable "charset" {
  description = "The character set for the PostgreSQL database."
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = "The collation for the PostgreSQL database."
  type        = string
  default     = "English_United States.1252"
}


variable "name_database" {
  description = "The name of the database"
  type = string
}

variable "allow_public_ip_name" {
  description = "The name of the public ip"
  type = string
}