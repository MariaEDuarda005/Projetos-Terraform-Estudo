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

locals {
  environment_prefix      = "dev"
  resource_group_name     = "terraform-${local.environment_prefix}"
  resource_group_location = "East US"
  tags = {
    Project      = "terraform-${local.environment_prefix}" #⚠️#
    Owner        = "maria_ferreira"                        #⚠️#
    CreationDate = "21/02/2025"                            #⚠️#
    Environment  = local.environment_prefix                #⚠️#
  }
}

module "azurerg" {
  source = "./modules/azurerg"

  resource_group_name     = local.resource_group_name
  resource_group_location = local.resource_group_location
  tags                    = local.tags
}

module "network" {
  source = "./modules/network"

  virtual_network_name    = "terraform-network" #⚠️#
  address_space_network   = ["10.0.0.0/16"]
  resource_group_location = module.azurerg.resource_group_location
  resource_group_name     = module.azurerg.resource_group_name

  subnet_name                   = "internal"
  address_prefixes              = ["10.0.2.0/24"]
  network_interface_name        = "terraform-nic" #⚠️#
  ip_configuration_name         = "internal"
  private_ip_address_allocation = "Dynamic" #⚠️# Options: Static, Dynamic.
}

module "virtual_machine" {
  source = "./modules/virtual_machine"

  virtual_machine_name    = "terraform-machine" #⚠️#
  resource_group_name     = module.azurerg.resource_group_name
  resource_group_location = module.azurerg.resource_group_location
  size                    = "Standard_F2"
  admin_username          = "adminuser" #⚠️#
  network_interface_id    = module.network.id
  username_ssh            = "adminuser"                             #⚠️#
  public_key              = file("C:/Users/FMR8CA/.ssh/id_rsa.pub") #⚠️#
  caching                 = "ReadWrite"                             #⚠️# Options: None, ReadOnly, ReadWrite.
  storage_account_type    = "Standard_LRS"                          #⚠️# Options: Standard_LRS, Premium_LRS.
  publisher               = "Canonical"
  offer                   = "0001-com-ubuntu-server-jammy"
  sku                     = "22_04-lts"
  version_image           = "latest"
}

# Outputs para exibir as informações
output "virtual_network_name" {
  description = "The name of the virtual network."
  value       = module.network.virtual_network_name
}

output "subnet_id" {
  description = "The ID of the subnet."
  value       = module.network.subnet_id
}

output "network_interface_id" {
  description = "The ID of the network interface."
  value       = module.network.network_interface_id
}