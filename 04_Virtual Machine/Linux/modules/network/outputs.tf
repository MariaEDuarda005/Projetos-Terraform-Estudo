output "virtual_network_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.vn-tf.name
}

output "id" {
  description = "ID network"
  value = azurerm_network_interface.ni-tf.id
}

output "virtual_network_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.vn-tf.id
}

output "subnet_name" {
  description = "The name of the subnet."
  value       = azurerm_subnet.subnet-tf.name
}

output "subnet_id" {
  description = "The ID of the subnet."
  value       = azurerm_subnet.subnet-tf.id
}

output "network_interface_name" {
  description = "The name of the network interface."
  value       = azurerm_network_interface.ni-tf.name
}

output "network_interface_id" {
  description = "The ID of the network interface."
  value       = azurerm_network_interface.ni-tf.id
}

# Output para o IP privado da máquina virtual
output "virtual_machine_private_ip" {
  description = "The private IP address of the virtual machine."
  value       = azurerm_network_interface.ni-tf.ip_configuration[0].private_ip_address
}