# 2º Modulo
resource "azurerm_virtual_network" "vn-tf" {
  name                = var.virtual_network_name # "example-network"
  address_space       = var.address_space_network # ["10.0.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet-tf" {
  name                 = var.subnet_name # "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vn-tf.name
  address_prefixes     = var.address_prefixes # ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "ni-tf" {
  name                = var.network_interface_name # "example-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name # "internal"
    subnet_id                     = azurerm_subnet.subnet-tf.id
    private_ip_address_allocation = var.private_ip_address_allocation # "Dynamic"
  }
}