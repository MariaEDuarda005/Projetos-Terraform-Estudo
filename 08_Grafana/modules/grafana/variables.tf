variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}

variable "grafana_name" {
  description = "The name of the Grafana dashboard."
  type        = string
}

variable "grafana_version" {
  description = "The major version of Grafana to be used."
  type        = string
}

variable "api_key" {
  description = "Enable or disable the API key for Grafana."
  type        = bool
}

variable "grafana_ip_enabled" {
  description = "Enable or disable deterministic outbound IP for Grafana."
  type        = bool
}

variable "public_network" {
  description = "Enable or disable public network access to Grafana."
  type        = bool
}

variable "zone_redundancy" {
  description = "Enable or disable zone redundancy for Grafana."
  type        = bool
}

variable "identity_type" {
  description = "The identity type for the Grafana instance (e.g., SystemAssigned, UserAssigned)."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Grafana resource."
  type        = map(string)
  default     = {
    environment = "production"
    created_on  = "2025-03-10"
    service     = "monitoring"
  }
}