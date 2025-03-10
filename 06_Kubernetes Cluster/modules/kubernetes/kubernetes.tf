resource "azurerm_kubernetes_cluster" "aks-tf" {
  name                = var.kubernetes_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.kubernetes_dns_prefix # "mariaterraformaks1"

  default_node_pool {
    name       = var.name_default_node_pool # "default"
    node_count = var.node_count # 1
    vm_size    = var.vm_size # "Standard_D2_v2"
  }

  identity {
    type = var.type # "SystemAssigned"
  }

  tags = {
    Environment = var.tag_environment # "Production"
  }

}

