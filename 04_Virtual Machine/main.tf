# código de inicialização do terraform
terraform {
  required_version = ">=1.10.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # Desabilitar a verificação se exste algum recurso dentro o grupo de recursos
    }
  }
}

variable "prefix" {
  default = "maria-terraform"
}

# Grupo de recursos
resource "azurerm_resource_group" "rg-tf" {
  name     = "${var.prefix}-dev"
  location = "East US"
}

# Criando uma rede virtual no Azure.
resource "azurerm_virtual_network" "vn-tf" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
}

# Criando uma sub-rede dentro da rede virtual definida acima.
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg-tf.name
  virtual_network_name = azurerm_virtual_network.vn-tf.name # A sub-rede estará dentro da rede criada acima.
  address_prefixes     = ["10.0.2.0/24"] # O intervalo de IPs da sub-rede.
}

# Criando uma interface de rede para a máquina virtual.
resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name

  ip_configuration {
    name                          = "test-configuration-main"
    subnet_id                     = azurerm_subnet.internal.id # A interface de rede estará associada à sub-rede criada.
    private_ip_address_allocation = "Dynamic" # O IP será alocado de forma dinâmica.
  }

}

# Criando uma máquina virtual no Azure.
resource "azurerm_virtual_machine" "vm-tf" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.rg-tf.location
  resource_group_name   = azurerm_resource_group.rg-tf.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  # Configuração do disco do sistema operacional.
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  # Referência da imagem de sistema operacional que será usada para criar a máquina virtual.
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  # Configurações do sistema operacional.
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  # Configurações específicas do Windows, como habilitação do agente da VM e configuração do WinRM (para acesso remoto).
  os_profile_windows_config {
    provision_vm_agent = true
    winrm {
      protocol = "HTTP"
    }
  }

  # A tag "environment" é definida como "staging", indicando que é um ambiente de teste.
  tags = {
    environment = "staging"
  }

}
