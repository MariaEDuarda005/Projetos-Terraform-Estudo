variable "allow_public_ip_name" {
  type        = string
  description = "Name of the firewall rule"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "server_name" {
  type        = string
  description = "Name of the MySQL server"
}

variable "start_ip_address" {
  type        = string
  description = "Start IP address for the firewall rule"
}

variable "end_ip_address" {
  type        = string
  description = "End IP address for the firewall rule"
}
