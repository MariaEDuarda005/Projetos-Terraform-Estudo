# 3º Modulo
resource "azurerm_linux_virtual_machine" "vm-tf" {
  name                = var.virtual_machine_name # "example-machine"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.size # "Standard_F2"
  admin_username      = var.admin_username # "adminuser"
  
  network_interface_ids = [
    var.network_interface_id # azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = var.username_ssh # "adminuser"
    public_key = var.public_key # file("C:/Users/FMR8CA/.ssh/id_rsa.pub") # Comando para gerar as chaves SSH => ssh-keygen -t rsa -b 2048
  }

  os_disk {
    caching              = var.caching # "ReadWrite"
    storage_account_type = var.storage_account_type # "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher # "Canonical"
    offer     = var.offer # "0001-com-ubuntu-server-jammy"
    sku       = var.sku # "22_04-lts"
    version   = var.version_image # "latest"
  }
}

# file("C:/Users/FMR8CA/.ssh/id_rsa.pub") --> Comando para gerar as chaves SSH => ssh-keygen -t rsa -b 2048