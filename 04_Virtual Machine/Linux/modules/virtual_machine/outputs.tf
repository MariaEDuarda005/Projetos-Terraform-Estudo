# Output para o nome da máquina virtual
output "virtual_machine_name" {
  description = "The name of the virtual machine."
  value       = azurerm_linux_virtual_machine.vm-tf.name
}

# Output para o ID da máquina virtual
output "virtual_machine_id" {
  description = "The ID of the virtual machine."
  value       = azurerm_linux_virtual_machine.vm-tf.id
}

# Output para o nome do grupo de recursos da máquina virtual
output "resource_group_name" {
  description = "The name of the resource group for the virtual machine."
  value       = azurerm_linux_virtual_machine.vm-tf.resource_group_name
}

# Output para a localização da máquina virtual
output "virtual_machine_location" {
  description = "The location of the virtual machine."
  value       = azurerm_linux_virtual_machine.vm-tf.location
}


