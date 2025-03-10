variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space_network" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"] 
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes for the subnet."
  type        = list(string)
}

# Variáveis para a Network Interface
variable "network_interface_name" {
  description = "The name of the network interface."
  type        = string
  default     = "example-nic" 
}

variable "ip_configuration_name" {
  description = "The name of the IP configuration."
  type        = string
  default     = "internal" 
}

variable "private_ip_address_allocation" {
  description = "The allocation method for the private IP address."
  type        = string
  default     = "Dynamic" 
}
