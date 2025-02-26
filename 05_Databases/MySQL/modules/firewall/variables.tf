variable "allow_public_ip_name" {
  type        = string
  description = "Name of the firewall rule"
}

variable "server_name" {
  description = "The name of the MySQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "start_ip_address" {
  type        = string
  description = "Start IP address for the firewall rule"
}

variable "end_ip_address" {
  type        = string
  description = "End IP address for the firewall rule"
}
